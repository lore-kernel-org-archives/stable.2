Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091F347F763
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 17:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912717; cv=none; b=NXS6BXPfWEHT3769myH0+DPAhOonCkUK+lQ7yJ1G7tnh0Pp9St66Ciqwr9rBmkiRtiT0LKhYoMeRqOlDCMiZDOlrK8gFTJPSRS/TPDu/NuUjsc3F845lwc4ANATxF8xLJFh3AiSawkoU0ScNxUJiCxjkoTOkin70CnGugZZMX/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912717; c=relaxed/simple;
	bh=UyzJg1CGrCT6l9BIn9xt70V+4ZaVLdHp7djXGtqNNi0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VVTKiVt/zqk2yOkKQM14SSCJ8ySrdRb+mcSFqu0IOYIyC2oR3R/WCJotflJzHTude2gThBvvmiyCqAHsOmg9VOFz3sORdDlNmE34XXKv6N2612S3IWo2ZCSXyLvAjTW6MvKGY4wEUX/5DOGpSur3Usy05DK0T8boRdirvJnRNqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=EljJEzoC; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="EljJEzoC"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e61ac64ec3so28355785ad.2
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 10:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791912713; x=1792517513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VlswUne+avJ8bwCltZgy3YunaA6SJPVFCYyJDSRlVeQ=;
        b=EljJEzoCt96nWwC89w0iF8i7ACQQ+eGmbtAb00YZNq+44PtVj6C6fB0Z0ozedi3VWc
         1dUxuwrFu4ztzD/d/cLZIYCfZBlvkFOqAjqbUwux+b4wh2XrWXGcMMMN9s8kDsPOTrNw
         Y6hsTm5bwPELlwdm8UItaWzyr3zAXKns0YDcLCl8u6GVFuyIxEyVF4brshQk6yvrTo/D
         K1lvCGnazOETlYPmA2XeVWOndaS6u2PVpw4c/R9kGPzg7ibFTDrru+ApdlRYB6TaU15a
         7dQnqXbe1yrXTEt4DczX8RP6qimJ4UZubqTyK4nNCBWq36lxADFyHTSUaKYSoDlZesh/
         bnSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791912713; x=1792517513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VlswUne+avJ8bwCltZgy3YunaA6SJPVFCYyJDSRlVeQ=;
        b=2oZZNzGOPPbQTPVRuVsT3TxG/EBR584mu4jHVBh5ESy1iOX2ZT4NFcbWAUNj+GRnWu
         aAZVZW6xjxgLAqDGAWuW/6JyfJd6BoyJtf0BtJa96V6FuTG4J7Thy4Mu9lw+omuaBrn3
         CMLmBhqrjnB5vhzyfQgTuuKWmxHo0LiJ1q0VWFMNQZpahO4jX4VdXHDqx4Q1vy80kVr1
         3CCS6LZcF7/paGYrsSXzqhULxpod7PBMGgRz7SAEvzrLrZDbVFK/swknTB4SjV8UG/u2
         zs3SvIYUGn+jyJBMAgcVVX1XZYeuE5F2gCzZVXeP70ryt0TJihfInClr2ZUQOpZODFcH
         bXhA==
X-Forwarded-Encrypted: i=1; AKwUvBy9Sm3mletfPlNnHUbXGvVvdDV4A98axo0EiNLF27NT1VNYYdTONdQe8kUtnNX2RFIEv977fN4=@vger.kernel.org
X-Gm-Message-State: AFq9FYL8UJThpZ3OBiAeJ78/ZKmGp3Y6YlxA69KSrtS6bZD3G0pkFoWQ
	nZ3Bb4rDH37uA206ugADASD2HsJdpu5XQCcd3h2vAeAMQYY4fqpllcV05wZ00LRD+Ro=
X-Gm-Gg: AYBFou2pV4CrTIKULgWlrS7QdldWmn1PWOxvAjNIXitzvaRKSS6qxKUkEY6z+Ftsc55
	307EBzp+r7xgeaX6eJi4E3ns60S80J+HwcbZR7tbABLlQ3BVuSD5JvssZ0QyG/BlRvX0sFMbgRm
	4y+CctiPWDWKEinUjHmDK3JcKTxHwGNhQ0ACfvDG8OMoEH62gicTfu5/vhuCIkac7FHzb4BiSo+
	wyIgRPfly1qtoxw6mH4Y+IS7BUZRzy9rT6nF0CYQ//FilkeU4dgChQWwdNE0sIsxNZvhFT3bs9v
	FcVGz5Yg6mawgKOIwTcF8Vgt484Q0xeYhsqvjPC8vuaH0J7jeN/R0dRbfmcyNze8+YvuEWwjZoD
	Lulvwp1BhjxxVtQ+9tGu9lUz4F5ySri8y3O81eGkHNCsv3yO/XdvzSuNAUD+1aTM3y9dfekW53K
	rbtxrC0eihBxQlntJF9fEqCLiRJZyZ5rbs2jrSuaay/CcxI0z3SAerrN1K/o+4yy5JcTnJW87x0
	NAlnCpcyLqncUJYLK+Y
X-Received: by 2002:a17:90b:5830:b0:39e:6c68:c787 with SMTP id 98e67ed59e1d1-3ab3acea00dmr11915708a91.61.1791912713219;
        Tue, 13 Oct 2026 10:31:53 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:c51c:be8a:c517:276])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac6019ca59sm607396a91.9.2026.10.13.10.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 10:31:52 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: "Martin K . Petersen" <mkp@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH v2 0/2] scsi: mvumi: bound two firmware-supplied lengths
Date: Wed, 14 Oct 2026 02:31:43 +0900
Message-ID: <20261013173145.3412863-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two places in mvumi trust length/count fields the Marvell UMI firmware
supplies and never check them against the buffers they index.  An event
with the maximum param_count/sense_data_length makes mvumi_show_event()
read past the 512-byte event buffer and into the log; a handshake page
with frame_length >= 256 makes the checksum loop, which uses an unsigned
char counter, spin forever during probe (shorter over-long values read
past the page).  Both date to the driver's introduction.

v2: read the handshake frame_length once into a local and use it for both
    the bound check and the checksum, so an untrusted device cannot change
    it between the two (addresses the double-fetch noted in review);
    1/2 unchanged.

Yehyeong Lee (2):
  scsi: mvumi: bound the per-event parameter and sense dumps
  scsi: mvumi: reject an out-of-range handshake frame length

 drivers/scsi/mvumi.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)


base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.43.0

