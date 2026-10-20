Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792510889;
	b=xCm+0dsBajAsAhEwzHeZjy6TQOGksT+6SQnPXy/WqrTQpI/GFiG5uMQc5CMxR20N3fhz
	 /fbsrwIzrk4wynH9GDqsfnS29NvjWG53TBjanSicNF8CBtjELHo0jdFi9OpzgoWqRsoUV
	 2001uv8Ie0WajH/2wpuoiveDlOK8ycpYyb44aRWDM2/PnKUXQZlUvxa9Mm/hmuWmRd6kY
	 J2stgQw1acXRslpBvA4qPnClBaq2YLHLXtOFEJuOcaisT/XVTGqhSGlmQpsXM2wkMWZma
	 A7OVPL0tDbtCiqsT5EdKWsD2yQAWHO2sTrLDcDXmOxaH7XZ3URv87Ud35bHXaYEy0og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792510889;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=AXJqprv9+6P+ENzF/k+5lacW/cBAnnDkUQI8xHH+RXA=;
	b=q76/t25ZMT4p0pxW0VqBreMrokmihGr64R0qo5TAt60rD00e8dJNEZs0jn7mSIwNIClv
	 MjvH5JO1eTSMiNP/niPIN56b14co9dX7anvjKAu6HU2E1jzN3qJzynEnxmdLaFc5fBKzD
	 q4KySQhsumcXUCOxsa02BreniFQRTGNH1XV2EE1xK88v0ri2xVGXOtqoT/2p3LS0vwnM4
	 FT1+9j4lbNkd3zvu63CkytgEYiC60IN87yjsP1zg7x4sGS6DrKeqPPTbAWWgFJHuG9TrM
	 IDWU4VTgNYOjh0NN49K6R1hmxTE9NPeONvW2FfmEyCVj8EzssAaSNSMRSIKxT3yq48Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EzQeohJw;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4397560A261E
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 15:41:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4397560A261E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EzQeohJw
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a1ec92f655so9866835e9.0
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 08:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792510887; x=1793115687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AXJqprv9+6P+ENzF/k+5lacW/cBAnnDkUQI8xHH+RXA=;
        b=EzQeohJwvcRZ7jElyhjW9LNG5O3F4Ab4Pe+RTujXeI2BZ8FGdbFtAqPk71XIrpacVJ
         CxgJl33v0hknPRfSUnb2Y/19m2/yYHQNRLQji+VWxpwEuuGiMVx+Iwadv9JJi4GhdRRs
         BLgtW9NBVDnMhfiZrOPHVnyM9j82qiqkjFusfYsAyrA7AlqLXSDALVGP5Mh52GcbnWVb
         Ov78tTFh6tsS4a1ltVix6MHOk+JZKrKy76kh2+S6jE4e8G63SbKDKl/6ax+o/D2SRDYM
         k7nKZNeUXJS84LkgFj+eixY20sANVHr4IVxqNWVoM/sJaxnZ8mi0YK5e9htB+q4eYJel
         a0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792510887; x=1793115687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AXJqprv9+6P+ENzF/k+5lacW/cBAnnDkUQI8xHH+RXA=;
        b=wn8iHzqgRFwtmrY/XWdVecvlHhnuJznUAeGychP3kGb77D/exs0VvNJh/03vbLyull
         E8a1D2ePV1OEHCWTQpKQhw9XKlbxwOLy7yQmVJchdAKoGwXEiVUhqYlCRAv2Mg1J8Tjv
         1EGNFnbF4Dq5MBkA9N4IQi6Gme8laIZz5cREZEmMO5TUk9WUcDmom8ZvQ9tQr5CiSbaj
         Cu/uiUIyjHFhinM+vtm05IONmJmAgdIpU85FYJ1rqWrLrT4wY88dLC3SqJT7pIlZa8A4
         H0BZaAWXwu8RdsyI0l8L+nRWPsarWBViDMDTxEQ3pDizc0cwO6agjNpDWiVZ8gjz7Zc8
         KKSg==
X-Forwarded-Encrypted: i=1; AKwUvBzu2Wmvf8bPB1NTnKK46ekZ1kj5q9iMnmfXPqHFtUcMZyAZCF7a6ZrEvaZOfa1GdV+cA1KwpbA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKLIN6ne8eKT0wIPcXQR5r1rtuDrDsfkO+r5vUa6UR4bHowbo2b
	WxW1NRlzSGRixrgW1n0wJ+CX1Hk5R87l0E53ftNa0Lh53BOO6QpUw9Q=
X-Gm-Gg: AYBFou0sLNnaisHRFoz4dOA7C0cFZDW1LAf2kxDrEjs1s/BOM37MsI5UzDKuoX4TwqK
	ruqyRcst22cHn4ruLCZM5oQj462GzkmozoafaQq/Y2uEa0Yu9Tq52ZyCg/jWhAHCba9FT1eWPVW
	YmVerbsAiR6zatE60dfB43HajIRngy+ZkmaPFVrLuoXtNwN3pQ7fv184c60VR3jtkttLmAniB0G
	X+vQPH2SJ4TmHJvzmqfa2YZWUWspgivExvOfPbHi0eLF3+A1q23/nwC2mXpDQl1wGYlzdrrQdWo
	f9RXJ8FZE1pWr2S5eSJ2N//6gHDVyIkgl01C58PUYLCaZVszc5fqAfCv6jApzLdHHNK0mP61grX
	P20N1kN5gB6gOVY+29XrcAAUmNvd0aBSs9dm0+t+DFl9NS9GSWuiSoIYf9lUkNAmJ80jAHNNtAU
	D8TbPvhmuW3YfdCuOSX4sTIAxacj+8JT7IJD+fIcGfdGkCzMkNZQ==
X-Received: by 2002:a05:600c:4743:b0:4a1:d899:b62f with SMTP id 5b1f17b1804b1-4a1f45f8877mr54521095e9.0.1792510887344;
        Tue, 20 Oct 2026 08:41:27 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1cca31234sm256606155e9.4.2026.10.20.08.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 08:41:26 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Chanwoo Choi <cw00.choi@samsung.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kyungmin Park <kyungmin.park@samsung.com>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH 3/5] extcon: max8997: cancel wq_detcable on driver unbind
Date: Tue, 20 Oct 2026 15:41:17 +0000
Message-ID: <20261020154119.2568395-4-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261020154119.2568395-1-tristmd@gmail.com>
References: <20261020154119.2568395-1-tristmd@gmail.com>
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

From: Tristan Madani <tristan@talencesecurity.com>

The driver schedules wq_detcable as a delayed work during probe but
never cancels it.  If the device is unbound before the work fires, the
callback dereferences freed memory because the driver data is managed
by devm.

Use devm_delayed_work_autocancel() so the work is automatically
cancelled when the device is removed, matching the existing irq_work
conversion done in the same driver.

Fixes: af5eb1a13273 ("extcon: max8997: Use workqueue to check cable state after completing boot of platform")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/extcon/extcon-max8997.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-max8997.c b/drivers/extcon/extcon-max8997.c
index 9cddf08e06966..7048b9f6d8443 100644
--- a/drivers/extcon/extcon-max8997.c
+++ b/drivers/extcon/extcon-max8997.c
@@ -754,7 +754,10 @@ static int max8997_muic_probe(struct platform_device *pdev)
 	 * After completing the booting of platform, the extcon provider
 	 * driver should notify cable state to upper layer.
 	 */
-	INIT_DELAYED_WORK(&info->wq_detcable, max8997_muic_detect_cable_wq);
+	ret = devm_delayed_work_autocancel(&pdev->dev, &info->wq_detcable,
+					   max8997_muic_detect_cable_wq);
+	if (ret)
+		return ret;
 	queue_delayed_work(system_power_efficient_wq, &info->wq_detcable,
 			delay_jiffies);
 
-- 
2.47.3

