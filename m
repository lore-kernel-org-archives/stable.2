Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9AC55D88F
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 16:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790093024; cv=none; b=mRqnobKXEvrrW4hfUJ+AxDLEes7J5kwJjt21C8MFa8lXMSfEKvW5sYkun2je2jwx9pjKqXMEU3lO2QwIWOnnj//chWscI67RUWh+N+adSAzA1AW1azwpt4VZM8/P5TlVqiYDV579eGdSaiLMo8YinqhkfY263DiYCirOdeKRQLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790093024; c=relaxed/simple;
	bh=xFjz1bXpKWmQrqKqY61uacAPUPI3QZ6eYhAh9Owlzjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iTZHeQypJLxecjyNvS0hFVASN8dD+hdaAaT/MI4jJInR5XfEY39lhwypQYLQ6TeYwBn0ibH4+ndRgbwf2neWQOvGt5RBBfXXryZzoL1uHE7IB4cIvOUhl6nftcKO574s+IwG5yZ7klTDAYJu6wHsXks7+0cQ0WvSKjeBTFUP0bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1YhRUDd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1YhRUDd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9FF1F00899;
	Tue, 22 Sep 2026 16:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790093013;
	bh=i9sQ533qpy7UR6h+LSpqplZHvpWM1j3O5yoWjEuwvos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i1YhRUDdhuyVMpxRLVB6/WWOWNZjY/HksVm/Vt98MB9YNdQrmBjbWFI4rokjF+6XQ
	 nhJISu4FAHgFw8k9Qwg+blWnMXZWQXkJFqydtl4r4eAlVX0WXHcLcuMrmGeQvDOny2
	 31sW8VUaMKyQNNZUbsvcTvr6uSpSA4lQtVi2MCtSmC0Y6hetD7Rah3QPjBldf7RD+/
	 3EBg5P0xyaBXLNZFctdtdghD4xBKAk/tTrzEaz0E1gg11gKyO2irSC5iqZf0ELlgic
	 E6inHqGeAybhgo869lzDLoVy2JMAU/4Fgm/Bo/su/VOzcF+OYzLoDwm+99tbBjGhHr
	 DiAvD2EyxlxeQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Karan Tilak Kumar <kartilak@cisco.com>,
	Sesidhar Baddela <sebaddel@cisco.com>,
	Arulprabhu Ponnusamy <arulponn@cisco.com>,
	Gian Carlo Boffa <gcboffa@cisco.com>,
	Arun Easi <aeasi@cisco.com>,
	Hannes Reinecke <hare@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/5] scsi: fnic: Bump up version number
Date: Tue, 22 Sep 2026 12:03:26 -0400
Message-ID: <20260922160329.2942693-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922160329.2942693-1-sashal@kernel.org>
References: <2026092249-remedial-elsewhere-96be@gregkh>
 <20260922160329.2942693-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karan Tilak Kumar <kartilak@cisco.com>

[ Upstream commit 47e088c9d1a06e0f762ac7ea62ae48c9e16c4def ]

Bump up version number.

Tested-by: Karan Tilak Kumar <kartilak@cisco.com>
Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
Reviewed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Reviewed-by: Gian Carlo Boffa <gcboffa@cisco.com>
Reviewed-by: Arun Easi <aeasi@cisco.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
Link: https://patch.msgid.link/20260217223943.7938-5-kartilak@cisco.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: 0cb1fd924126 ("scsi: fnic: Fix missed link-up when critical IRQ targets offline CPU")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/fnic/fnic.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/fnic/fnic.h b/drivers/scsi/fnic/fnic.h
index f47e363cc3d88..2cd1ec19acde3 100644
--- a/drivers/scsi/fnic/fnic.h
+++ b/drivers/scsi/fnic/fnic.h
@@ -30,7 +30,7 @@
 
 #define DRV_NAME		"fnic"
 #define DRV_DESCRIPTION		"Cisco FCoE HBA Driver"
-#define DRV_VERSION		"1.8.0.2"
+#define DRV_VERSION		"1.8.0.3"
 #define PFX			DRV_NAME ": "
 #define DFX                     DRV_NAME "%d: "
 
-- 
2.53.0

