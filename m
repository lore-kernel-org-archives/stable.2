Received: from forward205a.mail.yandex.net (forward205a.mail.yandex.net [178.154.239.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D59B395AF2;
	Tue,  7 Jul 2026 15:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783437648; cv=none; b=Uxn6FghMXgCCmG/XObWNMokjeICek9llpiluUHMLTQJBCQBBXsXimXSXbs71al66FRxCSX/DeJbHEvDye6ZD0+7qbhvnrTY/oz0y4bllfLdDIpmjzpjO2Fg3Bh8ilISv2c0PUkyfhPidGg+c9tOFLgGu9IMPOhvmVVDJMenQEf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783437648; c=relaxed/simple;
	bh=MvQ5IhOcJ312c1Cc35IPRjAWxRyOnJpVK6I5+c6nNck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q4GUqEicOkBIUzV8dZAEEnqgq9JvdMLdN+e4NAxIAgGs6gEgYHk874EkXvH0t74wIxAYB2DDo6OaBSVjCOkaRYPDV87/WypM6JMM3l8Dtq87+lpzhtBZtbcYC+cvN8CkgXZKmJAroj33EodU1ozohZvBZPPdNDIzOqRH1MlmjME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=nb3FNPKF; arc=none smtp.client-ip=178.154.239.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="nb3FNPKF"
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d100])
	by forward205a.mail.yandex.net (postfix) with ESMTPS id 2A0E4C5A21;
	Tue, 07 Jul 2026 18:14:50 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:582e:0:640:200:0])
	by forward100a.mail.yandex.net (postfix) with ESMTPS id 2144CC03BE;
	Tue, 07 Jul 2026 18:14:42 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net (smtp) with ESMTPSA id DEKSRuAfReA0-iQcqHiMe;
	Tue, 07 Jul 2026 18:14:40 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1783437280; bh=VqwoGV4lGjhRq70DnNTSh9Jinhadlp1128GtY/C7dwc=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=nb3FNPKF2AvbHZQyRSDbmCyJcaYRzwSI5Eo2drYZqSh1/KsY7szLrimllkrjnSFuL
	 vQSfIci3lENYuIUPvXhdbbvj/ZGfqCxZEzwPskzecTGJIDHMdKFU5Ela8q1uZDDobs
	 0dMDW8g8njMBw2JPzGFBYNLi6qAfiY5SVSCpuvGg=
Authentication-Results: mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Evgenii Burenchev <evg28bur@yandex.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Evgenii Burenchev <evg28bur@yandex.ru>,
	perex@perex.cz,
	tiwai@suse.com,
	kees@kernel.org,
	eblennerhassett@audioscience.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] ALSA: hpi: Check transport errors during HPI6000 adapter initialization
Date: Tue,  7 Jul 2026 18:13:58 +0300
Message-ID: <20260707151400.16437-1-evg28bur@yandex.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

create_adapter_obj() retrieves adapter information by calling
hpi6000_message_response_sequence(). This function reports transport-level
errors through its return value and DSP-reported errors via hr0.error.

The current code only checks hr0.error, causing transport-level errors to
be ignored. As a result, adapter initialization may continue with an
invalid response.

Check the return value of hpi6000_message_response_sequence() before
examining hr0.error.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 3285ea10e9b0 ("ALSA: hpi: Add AudioScience HPI driver")
Signed-off-by: Evgenii Burenchev <evg28bur@yandex.ru>
---
 sound/pci/asihpi/hpi6000.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/pci/asihpi/hpi6000.c b/sound/pci/asihpi/hpi6000.c
index c8d1518ee3e7..fd7fe9dba0b8 100644
--- a/sound/pci/asihpi/hpi6000.c
+++ b/sound/pci/asihpi/hpi6000.c
@@ -537,6 +537,11 @@ static short create_adapter_obj(struct hpi_adapter_obj *pao,
 		hr1.size = sizeof(hr1);
 
 		error = hpi6000_message_response_sequence(pao, 0, &hm, &hr0);
+		if (error) {
+			HPI_DEBUG_LOG(ERROR, "message transport error %d\n",
+						  error);
+			return error;
+		}
 		if (hr0.error) {
 			HPI_DEBUG_LOG(DEBUG, "message error %d\n", hr0.error);
 			return hr0.error;
-- 
2.43.0

