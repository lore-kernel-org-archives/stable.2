Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795625261;
	b=USDjvLA8ZIgEEqaNDrH84QzNzl9jK07FCe/DF4dz1qHJkh8uPuFgIY3BEcl4Oe7r8k1/
	 5avmTl+92o7QUxbSNQl035e/33GghJexqVeKGcOMdkoTVHsN8ge/sdnffxsI20h2xMzff
	 hsUUNQAwgwnx0Tp2sx6KllPmv9QY6lQyYGpfsAU+OuEdp+tsZDkUS7f6QYjdHUpFmDl1j
	 r2IDBqSqORUPsq3DpsZjbPreRS1wbbu4TKIWzlWTNAAmNF6oWFnDiZaUbfc1syrkdiZGS
	 XAYYtaCqoUhL6CLaRiLa9rUxgDUvVUYIiJi7NatDZ0WQDlvVKR7r5utmeacIQnwpgAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625261;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=k1C78Uc1W59p66k/nD/Zj6PrIT29VxqTwRjxHQ+aiV4=;
	b=1rG42RSN5Pagr3lHxh6gFPU+WyiliaY5NN6L8scTVGdKxVZhPsJFB8dqEMGfQzNa2697
	 IwGlGw5wX4fQdckXM6UEZJm3k1M4eD12TkeyRJ7BmRdXeodx+novK7VY9Qga00qiPj82Q
	 K0C71R849F69I7JrikNhhcStXiBQYmiIh6hejeTS7ru7eWDhjSjOjf3n0M7ULsh7cbNkW
	 o2YskZdYKqJ56RVZCbYQrid3QtfaojwG9rii/H/CzeBMgbQSEITCwe1HH7IMlbbXzt1BU
	 WKHXo3hIHQijdFabfL3pRkkg9JEt6WkiNKDjPQ6uukn4uToWjEqGrv/29ehyI9eMRpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rB4+0FqZ;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF722606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:47:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF722606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rB4+0FqZ
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2f02ee04378so47962005ad.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 08:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795625260; x=1796230060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=k1C78Uc1W59p66k/nD/Zj6PrIT29VxqTwRjxHQ+aiV4=;
        b=rB4+0FqZ1CZz21tsa67voyk2x6NXgq81CuBWayyF4UYmvBgatYBVaNcj/3ozmZ/iiM
         Da08/9XHKbYf1SubiB0vnwwEfpk0cUM6dbMszpNggH1KM4iTht9Y2Qycao7aHdIFLIKO
         weAIxXq1I4sRGtOJxXW6XFU1Pw5oqUyb1tCMu+Ks6RdklZBC+nzotf/WNkFKsIIP6tuW
         OPAGrBEDHx/2Gu/lquPrKXhMrcQ7fanP0jl1JoF0T7kOJ1o6zExCytCUu+WanrH6GsCi
         z2AxidbqRuqhFKtm8Q1IWm3dnCt8cAQGcfSJx5r2wEdC1HmXbDPeSnpuFWgG1WWF2lCb
         e18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795625260; x=1796230060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k1C78Uc1W59p66k/nD/Zj6PrIT29VxqTwRjxHQ+aiV4=;
        b=ObFgBklRDGnZNXydQFD/jadU6KQYEZ+hqKa49lz3P4KDADHjPuEgOHvzgLMOTg1X4F
         X4AUsO3UStqx6YJ5K6PJgV/+yZ1LzOvbN/Tqf+Fjf2c5GB8Ra2mOxMwnWpv+7sM6qRY1
         els5pUXfjfsfDl/1oIF79kUhG3KQZW0oHG1jhbs0soEoJ6iXj9LSvT8PvQN5E+dj35FH
         CP4/KGVu++mmZIFpW//F41PO1WevtJFMuzYZaE99/yC0+JcV/wIl46VZxFZop8N7L8/i
         GU28k/jNroUfQCw9LYdXMYNEGBQ8DCT/k+B8wIQbayR8t36ee8jtTveM6z39DY11Pwcm
         4K7g==
X-Forwarded-Encrypted: i=1; AL+hErGqVRgBdEXWRT4vdXOsqRVDknjOpq5zK5FlkleuKfP7F+ulA8OGNZ/syxHuEIaKFdwI9Sx/h70=@vger.kernel.org
X-Gm-Message-State: APuU4Z8N0wkRWq2oT5B0TuWbgUQ78dKyh9phOhP1O+iSIr/Q1RoQhIC2
	YRDD4/5Ygddnn5uI/yH6GzU6cOLO2KhKcR8YQhcr/qRTZQXdEKsbDDbr
X-Gm-Gg: AZFdTZcEhK2MN3rvctR7YUVnpeMb578zo5D0VituVXzNYh2rIQZsEbAJxgT96ZOZeeS
	CAnG4STwM9toReH0py8UDCS7bOUVcrqV8eW3IdYy0ZzSD7Os1QIIq5qcPeRS/Xtn1P2aesMiBa6
	4evSDaOwq1LxJdGICWFKG6vh61pJNOUkAKB3n9NQGUH+lGvTaK0F304JYWsabdispvlHbiDc3iu
	K2cDA6KTv4kZItfg+dzXfCkjAuGD7yHRUBA/V6v+qJqwsPpnXWGcBoNUQl3dpYuOtpcehZ4mJE4
	k1ecdoyUUqGJQ+rIcpYKdLNQqPI/ddzFpSUSDWVbDIkYgSXZnPLG70AgP/bdZ+aQV9o/VSf9HED
	OQOPuRT8kHLQkhxUYHRL+0N3+3mtB6QwUwUddBPTtOIgvv4LBw7d8WfgL0BtAE3CkiE+nsU7fCl
	iBf6aSOKp4KGBiLiO8kTzgVcmLrykAn5jj06vmYYMUo82m/quBjoQriffOOKXxDGCEYN9DsBvop
	ZiIwhfjcWRF9HnkBlo/X2H6zLS/evC8uWPM6zgJhXq7X1j/FdLTS4++nHTAJu8wRBG4211e6YMT
	RLIUku4V65wnZwIXkAfRP0gtNQ8NNdnHBcfQgHHajHDOWmWLfAQI+jgXMmw/2ezW
X-Received: by 2002:a17:902:ce85:b0:2f0:3e44:4761 with SMTP id d9443c01a7336-2f03f25e801mr192769945ad.54.1795625260030;
        Wed, 25 Nov 2026 08:47:40 -0800 (PST)
Received: from cps-manycore-1 ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0dcbe3sm89876535ad.28.2026.11.25.08.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 08:47:39 -0800 (PST)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Shen Yongchao <grayhat@foxmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] HID: bpf: fix use-after-free in hid_bpf_reg()
Date: Wed, 25 Nov 2026 16:47:18 +0000
Message-ID: <20261125164728.24914-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.56.1
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

hid_bpf_reg() keeps the reference from hid_get_device() in ops->hdev
and adds ops to prog_list. After prog_list_lock is dropped, a concurrent
hid_destroy_device() can put that reference and free the device. With
hid_rdesc_fixup set, hid_bpf_reconnect() then runs on a freed device:

  BUG: KASAN: use-after-free in device_reprobe+0x111/0x1c0
  Call Trace:
   device_reprobe+0x111/0x1c0
   hid_bpf_reg+0x3ce/0x420
   bpf_struct_ops_link_create+0x39b/0x4e0
   __sys_bpf+0xaca/0xc30

Hold an extra device reference until hid_bpf_reg() returns.

Fixes: ebc0d8093e8c ("HID: bpf: implement HID-BPF through bpf_struct_ops")
Cc: stable@vger.kernel.org
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 drivers/hid/bpf/hid_bpf_struct_ops.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/bpf/hid_bpf_struct_ops.c b/drivers/hid/bpf/hid_bpf_struct_ops.c
index c90b68956cb3..e2512bd6e6b2 100644
--- a/drivers/hid/bpf/hid_bpf_struct_ops.c
+++ b/drivers/hid/bpf/hid_bpf_struct_ops.c
@@ -198,6 +198,7 @@ static int hid_bpf_reg(void *kdata, struct bpf_link *link)
 		return PTR_ERR(hdev);
 
 	ops->hdev = hdev;
+	get_device(&hdev->dev);
 
 	mutex_lock(&hdev->bpf.prog_list_lock);
 
@@ -239,6 +240,7 @@ static int hid_bpf_reg(void *kdata, struct bpf_link *link)
 		hid_bpf_reconnect(hdev);
 	}
 
+	put_device(&hdev->dev);
 	return err;
 }
 
-- 
2.56.1

