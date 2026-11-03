Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793713848;
	b=Uwno3IxpAOuwmhLQCmC6uD0NGrDL+sYeYU253DU66cCb7scbLbTfwQ3p0jnUmEmXhPzH
	 yh5qo4AFTBHWON2S5gKAcLp/d2cCk22HfYm65ijWofKnwgo7lk65eYja7CB7K9UL6u6O3
	 A53AdALhGg2Hp0ETfbIudEpI61LQzuXFs2yU+AVNv/2AiOJG9ltYzVe2T0D7YLeEKwPgD
	 IYDIXGtNdks70kxxm+a41xYuIqSYeGfvTH7acFfGxRf79DOJagyMnN2xT8CufuzgITdAk
	 eiXzXZ9ocHYNMvXIn7z1EI/7+S9FaWQSWWfY4/owYLhyyc3moGiVR5CjSpo87aLqtlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793713848;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iz8THq3Ta5/c6lJGQpR1glZjC7mwlp4rMFLr7kynKic=;
	b=gqSqlNeIVQMr3GUjznxT/SssTzXgNSV5EPxZuxNRAjtFdQgudd8VNZUdfePzeyQbZIHu
	 dacjI4TcRkumB/Kgpiiq/izwk2m/HBPw0hIgUIeKcWT1hsEGckh16u7ZiD0syBMFay/Gr
	 J80+qQjRXuO3/C9Zy7PzacNaD9QUOI4tgZFXUtXjeFO6fwHv7Bmq8mx14yP6ttB3HG7Mf
	 lX4hKLVKqyEDzrElr7BEPnw+9HI4u5A2VQcW43sL6Ie8HaSnIiSZYJKWBXVAhTmXwDs9f
	 mjtqfg4Fn+tjt/WXqK+YVhChJbMU7Top715RDKxhL9vlQ9enFllai3T8I1zekFdVA/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m+cGWw8H;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55DC606A33D
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 13:50:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D55DC606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m+cGWw8H
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1b1ce85287aso2127485c88.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 05:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793713847; x=1794318647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iz8THq3Ta5/c6lJGQpR1glZjC7mwlp4rMFLr7kynKic=;
        b=m+cGWw8HKJ8o6/4u8Q6E0ZLb/I3Bj5h5DWw7ICnAPKp4/EwJAuPzCkuy23H8DCc+dY
         +ND+UCXf6Isyw+r9M4VIyJd0A5TIxxqKpl5jqd7fHPQEa91T1xMUiSPei87Zz7ootcdQ
         lG9gX376h8ayU9xs+y0y9pq5tA6m824QkSwLuKCHYVAXxbjDHkpPFDX/Z5OZkFef4fUW
         GEyIa/KesY/b2Ohn15JyLZQdVnjWGaDWS2METlbt/acCnqqCGhZdAshzTbkNqTVCWiLK
         v+2b2rxqZiWPFWNMRMzUxzqEmT8lBACT2/nkzmcrejuwEcHIoV/92SB3+Bn0oQZ4JQIw
         XQ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793713847; x=1794318647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iz8THq3Ta5/c6lJGQpR1glZjC7mwlp4rMFLr7kynKic=;
        b=i01iZ0I39drmmqhwkpRsa4HulvcaI7ijrysCRbVrFfWPSXad/nb6kXYkfdaho4UIeT
         i1CrQ0auNFdWDzH1Rjx6oK5V2xi38kWbkryP+7Xk5MMzBLZWGH4cyoqDEzPO3IW9ggKU
         uVi6xZARjtbYbUeGBQjX9hqgzLPSNKwQgTaWYkllS5m8O9DdQ4Oqf1p6YXTal84b+ckd
         5aFdmpbFAFYxsQgNw4XCIYpqcQZVBznsQkLlwvAHHzBftGIasAykm68lWWQbPYDjWlik
         iIZqy290+NtjieR17aepVwJAarOgO4I962uAS6vqssZoFAphdolxaKBHD8Qo0d2fettY
         b7XQ==
X-Forwarded-Encrypted: i=1; AKwUvBwb4IZ2JTJ7clIUOoc9OYW8qANtFYoOKXbQtKk5ie3AqslaTIoXLW8ZGWDm68CG68O5YgYgahU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/0t7IMKKdKPUFCRjO8xrH4BIPwa04ZNo7Ku36rWCzQLaOyz0Vj
	YGd5GgPbxZie1V2iawzWlr797e1HjkN7N2mU4A59xikd8Clfx0bCpW2B
X-Gm-Gg: AYBFou3A2K5Q+bSWkFH16LIMSJJ88q9fFQyg3tVVIS45uURGx4FJ+iiK5I/8cmXnZoS
	ShLd/FZEQVcxlVT1bAL1TKKhdcLuMIjqsw8h/q6rzPYjmK6LR/M0tXcxOHY5RDJOPw3GVP0viIM
	WHInM1jDQrKBYupZtEyklFesbI5TH7bfYWay0Vols2pDV3mSMWgmBw2cXiMeut6nmLJTkqn0+pX
	cqSFqi7a0XQmdI6oud4TB3LrLCB0cD2s3Ar4eRIt3Bi2WOc0RJ94RNesxMGENWXwFgcJQkhQ4MO
	0s8UkYrSZ3omK9mWieGHH+Y9pKX8xGj9rYsSn/nDjNFXF2b0Wq1RyLPm4X64ecH8IEBnutm4+bF
	V4AnwusmYNP38VHwN4SS2AgtvfjhFcZLPFIS7itUvE5yD51RDPP8nnGekcHeXtJQPDXvbTGkyDx
	N9ygSC8l5xHMUS/oFOX1F6jqywN//zuXwy7UNxxLg8JaGVtnpbQEtA/S5A1PQ8eYFLDvwSshDLK
	MiRFGe4Skp1MMqeSCy3CQsGKDpdqz4RbvMSy3Hv69ElyM9gOswywXlzlnn/V9J+f89gYNmGN+Rb
	K4Xhe+KeASxO9hJdDxgAqBbM6+L5XiS6tmsZI6Y4Aal8Pkp5bAdxu4rK+wXyxuokOw==
X-Received: by 2002:a05:7022:ef12:b0:14d:ef19:246f with SMTP id a92af1059eb24-1ac5f36d5cbmr21734399c88.45.1793713846762;
        Tue, 03 Nov 2026 05:50:46 -0800 (PST)
Received: from DESKTOP-NM9EKIA ([125.134.240.130])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac0e738445sm44055965c88.0.2026.11.03.05.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 05:50:46 -0800 (PST)
From: Joonhoe Kim <26rote@gmail.com>
To: heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: neil.armstrong@linaro.org,
	dmitry.baryshkov@oss.qualcomm.com,
	tvlad744@gmail.com,
	linux-usb@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] usb: typec: ucsi: Leave the mux to the altmode driver for alt mode partners
Date: Tue,  3 Nov 2026 22:50:46 +0900
Message-ID: <20261103135046.1654-1-26rote@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 25a2bc21c863 ("usb: typec: ucsi: call typec_set_mode on
non-altmode partner change") set TYPEC_STATE_USB only when the partner
flags were exactly USB, so that the altmode drivers set up the
switches, muxes and retimers for alt mode partners. Commit 226ff2e681d0
("usb: typec: ucsi: Convert connector specific commands to bitmaps")
turned that into a test of the USB bit alone, so a partner that
reports both USB and alt mode now gets TYPEC_STATE_USB as well.

On pmic_glink platforms the altmode driver programs the same mux chain,
and the two notifications are not ordered. When the UCSI connector
change comes last, an FSA4480 switches the SBU lines off, the
DisplayPort AUX channel stops working and the sink is never detected.
On the Lenovo Y700 Gen 5 (TB323FU, Kaanapali) this happens when a
DisplayPort sink is plugged in during system suspend.

Set TYPEC_STATE_USB only when the partner does not report alt mode.
USB4 partners keep TYPEC_STATE_USB, as they do now.

Fixes: 226ff2e681d0 ("usb: typec: ucsi: Convert connector specific commands to bitmaps")
Cc: stable@vger.kernel.org
Signed-off-by: Joonhoe Kim <26rote@gmail.com>
---
 drivers/usb/typec/ucsi/ucsi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 2f9adf4f8bde..395554ba0312 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1356,7 +1356,8 @@ static void ucsi_partner_change(struct ucsi_connector *con)
 			typec_set_mode(con->port, TYPEC_MODE_AUDIO);
 			break;
 		default:
-			if (UCSI_CONSTAT(con, PARTNER_FLAG_USB))
+			if (UCSI_CONSTAT(con, PARTNER_FLAG_USB) &&
+			    !UCSI_CONSTAT(con, PARTNER_FLAG_ALT_MODE))
 				typec_set_mode(con->port, TYPEC_STATE_USB);
 		}
 

base-commit: 7649ba73f9e7e1e04d0b46213e39c79ae09dd55c
-- 
2.43.0

