Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586AD4A3F2E
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 16:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791217102; cv=none; b=YxzJ3N6+2AziwTc2yAHY9uYSDYHWOTpn7gAh1TLBrlFZTYX+Gvv8Y4fOYJcdKY36a9VrkhL8fC4H3AtM30yi2vwM7KdvE4tgRQuSUj5YKLdSBuvqf0n7Jet/9hzGrljxZ4gnoL8Ls+uJQsn8mncitlPgJSMQpS8RriExl9VqZJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791217102; c=relaxed/simple;
	bh=oxMp8tgRxkn5p2bkt4+pwTFbr6APVri8jSe9stE/wrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e/aPvOsJIqRN0I1hW6uXNLhuzpvy/fPrlnqUmzAxsF3Lmi7at1eeqjpHg+ZRmBvj/DlQePZ7cphUW49aPd6jU4VxWToY8oc3W7t9WtXr9WHT7JMyMQMPr2shrs5C9+V5tJwztc3Orf12q17khVaKjHGZnJS038AzvAKw73BT7v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSdT9B0A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSdT9B0A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5823D1F00893;
	Mon,  5 Oct 2026 16:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791217101;
	bh=kdvCFk+f35nOVd39LXpKfdj7ONrfyPo6d8wi3sWkdls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HSdT9B0A9JgpfhcCyfwOlkEMfhVGEBgczu0BcCVfvzkVzshtwSWA3aOqcH1JeoCGC
	 wA0doxertrSO5rTNiafyjyt55yBqIzkkSquZLN3WJnwow6D+VzqUtdJ5yxWe4ZwG0P
	 /Rj8YUuhYh+f1O4YiX6Qx/1t6Z+q5GeYITK8/NOpS19TgUyH6z/YSMe963bf4QvMV4
	 nnNriKQEsjYw1ipYUjwaCH6+zwng41j+M3aof0Y3wlZ9SDUZ6zLSaD0iMNRuyB08OI
	 rJ1XDa1S/8xyxZH70eY3WCvCi6b6KiKID6ftRrEyBBAnAb2Nkw4cUTGtqDMD7l9RQ7
	 7tReumUoNPdMQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	stable <stable@kernel.org>,
	Ijae Kim <ae878000@gmail.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] usb: ohci-spear: disable controller wakeup on removal
Date: Mon,  5 Oct 2026 12:18:14 -0400
Message-ID: <20261005161720.3050479-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005161720.3050479-1-sashal@kernel.org>
References: <2026100503-protegee-laborer-f4f5@gregkh>
 <20261005161720.3050479-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Myeonghun Pak <mhun512@gmail.com>

[ Upstream commit b1b0f8bdbbc891a4ee7f3b1a878c633e02b7bbeb ]

Probe enables controller wakeup after the OHCI core marks controllers with
RemoteWakeupConnected as wakeup-capable. Removal does not undo this, so the
wakeup source can remain attached after driver unbind.

Disable controller wakeup after removing the HCD.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: a6eeeb9f45b5 ("USB: Update USB default wakeup settings")
Cc: stable <stable@kernel.org>
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://patch.msgid.link/20260915012011.61874-4-mhun512@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/ohci-spear.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/ohci-spear.c b/drivers/usb/host/ohci-spear.c
index ed019c459ea0d..8dd9b77c12fd4 100644
--- a/drivers/usb/host/ohci-spear.c
+++ b/drivers/usb/host/ohci-spear.c
@@ -105,6 +105,7 @@ static int spear_ohci_hcd_drv_remove(struct platform_device *pdev)
 	struct spear_ohci *sohci_p = to_spear_ohci(hcd);
 
 	usb_remove_hcd(hcd);
+	device_wakeup_disable(hcd->self.controller);
 	clk_disable_unprepare(sohci_p->clk);
 
 	usb_put_hcd(hcd);
-- 
2.53.0

