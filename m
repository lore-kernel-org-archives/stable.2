Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1546F448CE0;
	Sat, 26 Sep 2026 13:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790428639; cv=none; b=KKe7mZwWxD6CdzvyvrebhNK1vsJoe6eCh7KEwp4Md7ohoSeY0aDBqlJQuCD7iQ5pqRGxpxrRLvVKKM+VlujsCawcOOKGWVa3A9eqXzR/f/ZBeuo7LRGN5UQmMKTZWCkJUJCN6B+Iym09BiLsZKyOCLJs7Y6kMaezbMescUaUv+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790428639; c=relaxed/simple;
	bh=TYvmmecMami2PR29JEAo0nLEjXwWhtuhMjvkFJ2CNPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NvyuVzDGG2lsSO6/ZR8gu6FlB8x1SjppFCv+JcfpqkPwnCg4473F7kwxLN+rbFWa0benmQr2QGrghPGz0QH/0vgQ3MEv1wZWC4Gux2qujubE4LXIiH1ZsZ5qJKS1RURXicZFaZXnzJuw9WiUZqJRQ2AZsPC0Ek3q0MTGSAl2oD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRa7wKuX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRa7wKuX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8DEB1F00898;
	Sat, 26 Sep 2026 13:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790428637;
	bh=53Vc8WVIQr3ly0MiN9XWVCDubq5i8iA9A9qjfXDRuWE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BRa7wKuX3bw2/eV1pOhXQ0qTNNdNXrUr8DdtjjxQ66H/QfIC0yz1VGW4eCKVDRLlt
	 uo2GurglwXgKbQnZLriw7O6qfybCepFV/PMXsZey5hlLrRNbD1azFN6YMPSXg/74mq
	 bDj2iY19taqI/sC9xsJ875dnxcEUoVKZyHDtzN8TMGKIQNr1OeX8611q/MQ9Thqy/r
	 lslHcxys8r1zRIBBin9kqDLDkRUXnbtJjqtCH3QJ4Rs9KsjGVGNQMDHMk/gC99ZWnY
	 JQiAx67oXpXM+rfEMpZJKId/K9tNTpIm3TWOhZdLdUKZavO9GyaI94sT61HcK/6Swj
	 vQIpmtQyHzsGg==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Sat, 26 Sep 2026 14:16:59 +0100
Subject: [PATCH 1/6] fbdev: ssd1307fb: check for fb_deferred_io_init()
 error
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-fix-fbdefio-error-handling-v1-1-a94810b6e263@kernel.org>
References: <20260926-fix-fbdefio-error-handling-v1-0-a94810b6e263@kernel.org>
In-Reply-To: <20260926-fix-fbdefio-error-handling-v1-0-a94810b6e263@kernel.org>
To: Helge Deller <deller@gmx.de>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 =?utf-8?q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>, 
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Bernie Thompson <bernie@plugable.com>, Greg Kroah-Hartman <gregkh@suse.de>, 
 Steve Glendinning <steve.glendinning@shawell.net>, 
 Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 Steve Glendinning <steve.glendinning@smsc.com>, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1319; i=ljs@kernel.org;
 h=from:subject:message-id; bh=TYvmmecMami2PR29JEAo0nLEjXwWhtuhMjvkFJ2CNPs=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLK2H70y5dyre+Xf3xw59OP3c6/kvF/SF1ZJbGb/Ub5iW
 9rc9PUNrztKWRjEuBhkxRRZnn8R3x8kEjav84K/G8wcViaQIQxcnAIwEcMCRoY17e2v6zT/MBz5
 vvnCv9Iwllnul3Z/SXjtohF67o8Z0yIrhv/Vuz9Ghgp+4Lvy+YS1bSGHPmvfqknCZ19vr12mM7M
 yOZIDAA==
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

fb_deferred_io_init() allocates deferred I/O state, populating
info->fbdefio_state, or leaving it NULL if an error occurs.

Currently ssd1307fb_probe() ignores its return value.

Therefore if an error arises in fb_deferred_io_init() (for instance, due
to an allocation failure) info->fbdefio_state is left NULL.

When the file is subsequently opened, fb_open() will dereference a NULL
pointer (calling fb_deferred_io_open()).

Fix this by checking for the error.

Fixes: 56c134f7f1b5 ("fbdev: Track deferred-I/O pages in pageref struct")
Cc: <stable@vger.kernel.org>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 drivers/video/fbdev/ssd1307fb.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 4d185c754284..8fd96c37ee1a 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -767,7 +767,11 @@ static int ssd1307fb_probe(struct i2c_client *client)
 	info->fix.smem_start = __pa(vmem);
 	info->fix.smem_len = vmem_size;
 
-	fb_deferred_io_init(info);
+	ret = fb_deferred_io_init(info);
+	if (ret) {
+		dev_err(dev, "failed to init fb deferred io: %d\n", ret);
+		goto fb_defio_error;
+	}
 
 	i2c_set_clientdata(client, info);
 

-- 
2.55.0

