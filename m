Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AAA3559F8
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 01:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785980122; cv=none; b=QcBdKOHp8ndTI4QAj4d/Eybha5Fk80awihbdG7MvCt3IrFf1xHXsJItLbrI3y5KO83VCM3HZOvrFDFqBYK8V89FChjsIIy2Qke97/hMiywEnMkGOdBcdkiP/EM6sylrVCIF0G3D/t65x4mgZJSAbKVJv+EhpImr/Br38qEp93Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785980122; c=relaxed/simple;
	bh=nwn2lZ3SCz5qyQG6mlgmrXj0cWktoRX0y3iA14280Aw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hTYbWZLa+uS2hg3esCqQiB3IgTBahhdRKN385bYq/TsflNV6TCNG4RqPVg+DfOxDBLmDL+Hmea5cWS6eKzzs4jMRy+K0WmJImmvs5+MKZ7cJQuFtgN6Uz2bIMATYqbFq8tgPLVi81d/oesQjJZC9DbmuXTmL+qiruTph+EcA9bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPCk4/oz; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPCk4/oz"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8f29ec73064so11276916d6.1
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 18:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785980119; x=1786584919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=L68zcBOEKqyAHNXodlM2tK6G5hxNC0P7ha7It9IyfZQ=;
        b=lPCk4/ozgel0NgLcQzErGQYvIEmpcPQyAPYszHioXVnoKawBltEuxH0dWV7V/X1Y5i
         XPbYipevNDTcLeAklMkcQe9uXJCG+1JAmdhD6nXMuNpwfj330zLchmQ86jdydWMHp1hV
         z2J3cjrdPfigN4yZVeInWfyAgC+B+OTm5D2imsZ5sjiRblFEbJCEnLp0Yhdd//HXdO1w
         J9obau6Mj7UmD/dbCmfkEvjnHQOwKeXEhRYIqApU9S0vqHa3fA+/j44QSi4Z4p1Fqhqt
         qAGYLxEHM6kozZXsXAGJ99MdjHHoqCqrzMsEE04Fn3W5xZn6p6jZV1RL5B156ovHGSCD
         C46g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785980119; x=1786584919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L68zcBOEKqyAHNXodlM2tK6G5hxNC0P7ha7It9IyfZQ=;
        b=qpuP9DPhIj68el1LqOyNnON4X55UBCyNrq3HTZmf4xGR703jbIqDXVrr95NxuqBpGK
         24RhY//id5Rg24IOuLCNdsaCmawgNLaWV/V1n6TBjxtc3yXuMCMn3vZMsn7vxeGRqAj+
         BcoxxRn5PcFXIlH81valEU+cHoNQPgQ86TnL6VxqDrOaqVtPCp9fKQhq4K1qCuyDZShM
         eD5t0KpNoE1TIa+Ugf/S6EII3v0yT3dqR23nwPWYM6g5IdPe+kD7GPjUQfm/orV2Pn/n
         GArO9s1R1kLmEOE0SUlvnEilJEXaxoZIGvrFwAGloimA1280oX9f4GkT5gNeeTRG5UVn
         T2rg==
X-Forwarded-Encrypted: i=1; AHgh+RpSL6senKk6IeZDgtesRjISd8KKzzxMTEsPrQPdvni+T9rVHM95Il8Trj0G71h8cFOOtXAXoQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNLUTMFIepsMALHpT4jMubOmvU/AAxg2/xBADi8NGwB/9hRg73
	6DGK3peuNSqLYZs5oYQzpZDzx5nkjy2bvlbs0UeKKV6bYW/vG9pASNLA
X-Gm-Gg: AR+sD12FhXeBDZTW7c18IGcsftUIQmIMBYqE1oDX9jDs0ozI6o9MQgLAo1glxmAnu6z
	LjyDlrqxLvShI/sXEM+Fx5TazaX8e5Inys3Ug1R0EovlZx9MIqtClPZvjlv5SHdWPALlKjr1pQe
	wgVNa/OkD/M1VyfcmG4IcjTh+E+e/55m5r/19Z8FHG9leh3IUgxnCng+zQDQC8MLgqlk02mHkGN
	09qtm3QF26AtsXgyqxzRfCV1Mg9MYLPFBywZ8NL6Jmf4eFlO7lE9bHOVeETxSSlTHeN6xv6h1zs
	aSVcike/w196M0ayKuh+MEfRmzbsNRO98TNnYVu7Guqvv5JB7sjUdplqENbYOMOtWVUKhXYrT+L
	MqdHtOePJ+wg/Ay02RC0L8KmMnu9e+aXynHNF4Rk0wrNT5g4u+07Z6Jqh1kIBmn4poh3bFIaihS
	CZCmr2k2twPJAdNhp9lsmsycy51q6KbKt21eU2GazcUB5w6irKzPzAOdvdLjk53dmNLzS8EvayK
	jCYwSXR9OO6UKQ5T6AfMpdxSqqB
X-Received: by 2002:a05:6214:1bc6:b0:8f0:3b2c:a9c8 with SMTP id 6a1803df08f44-908811d8ddcmr133559146d6.12.1785980119508;
        Wed, 05 Aug 2026 18:35:19 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908800add3dsm39453756d6.39.2026.08.05.18.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 18:35:19 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jacmet@sunsite.dk,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] USB: c67x00: fix use-after-free in c67x00_add_iso_urb()
Date: Wed,  5 Aug 2026 21:35:02 -0400
Message-ID: <20260806013502.322067-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When TD creation fails for the last packet of an isochronous URB,
c67x00_add_iso_urb() gives the URB back before updating the endpoint
scheduling state.

c67x00_giveback_urb() frees the URB private data, and the completion
callback may release the final URB reference. The following accesses to
urbp->ep_data, urb->interval, and urbp->cnt can therefore use freed
memory.

Update next_frame and cnt before giving back the failed final packet,
making the giveback the last operation that uses the URB and its private
data.

Fixes: e9b29ffc519b ("USB: add Cypress c67x00 OTG controller HCD driver")
Cc: stable@vger.kernel.org
Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
---
 drivers/usb/c67x00/c67x00-sched.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/c67x00/c67x00-sched.c b/drivers/usb/c67x00/c67x00-sched.c
index a832f5696f2a..ae6c94f41cb3 100644
--- a/drivers/usb/c67x00/c67x00-sched.c
+++ b/drivers/usb/c67x00/c67x00-sched.c
@@ -761,13 +761,13 @@ static int c67x00_add_iso_urb(struct c67x00_hcd *c67x00, struct urb *urb)
 				ret);
 			urb->iso_frame_desc[urbp->cnt].actual_length = 0;
 			urb->iso_frame_desc[urbp->cnt].status = ret;
-			if (urbp->cnt + 1 == urb->number_of_packets)
-				c67x00_giveback_urb(c67x00, urb, 0);
 		}
 
 		urbp->ep_data->next_frame =
 		    frame_add(urbp->ep_data->next_frame, urb->interval);
 		urbp->cnt++;
+		if (ret && urbp->cnt == urb->number_of_packets)
+			c67x00_giveback_urb(c67x00, urb, 0);
 	}
 	return 0;
 }
-- 
2.43.0

