Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597603;
	b=lD2Euvn0MKdd23rnMRECGVJu04MDqiVoakHHtw3iKBlWhYmh81U43tF6R80qpRqmRGqQ
	 6MDx1fz1xzLF0uFXhBxAYktC/Uy/JSlZYZ+eGQKd035yx0ly3L6IO6HyzdDYkeYXk+6Hy
	 GGZSkjW0qvDrsm8zZjBRSrEtSzzo3b9o3kQ9bLyn25RM5GTykSfM4XnC8Kjp1hkAwWjGw
	 PAbEc0YlJ2nT07C16htI37i6Yw0zqA8RFVDvBeTE7foeIkidmuE5h+kxRY2TKoDEvSf9u
	 7s7419P8AiJRC7b3CgAaFCPOTw6e1s1ZBaY2qgxVNQg4VHTu0bxhaNzHDUGHQX3o+og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597603;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=KDTgAMo9MoGmI6cUP6xYgmRM4jfbNullnyIPniAfJY4=;
	b=jYKkIT0wMcn6K3Y1CPfr1tYGQjVaR7VCm6unYYBFITtnQJYQHAfcnMIkwu4PI4miw4wH
	 Rq7kg5odXOb8KHA85o7k/dmOpb4wsZO4Je+RN6mAkknpeONaG6sQIvZGLGwrBFwyczVCQ
	 /y+Y/XQvtL3pWbSgszIIP1ODk+lUaRsZu0V9AYrQhIk07Xq4P6vPL4Il2Db9NnPuo9OY3
	 yJXlLtEkpwAw4vo3kp1mjdDRh/G5UZOUVA2tycgAO1lzJL6gh/P4m8KGkCI6AtFct1oGj
	 pVG+mtU7xJI5u8/LQC/ivEnGzYhSCC/Kr6LP1T/F4Z78cvk+OdJUIk0CAQmoN1WXHQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IqgwWaKj;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B02E606A326
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:06:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B02E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IqgwWaKj
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-38692f62b22so6155085eec.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 01:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795597602; x=1796202402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KDTgAMo9MoGmI6cUP6xYgmRM4jfbNullnyIPniAfJY4=;
        b=IqgwWaKj8WAcGY9LMkSxzjgT3RdVug0Bw7CwQWFNEAvIoE1ow8qz2M/fKLcCCUlW93
         83dck4cRSeXgltQZ2K62yyMkihRNJhnU2Ea76gS6NeeSW4Spi2PqV0im3L8TnrXnnAMU
         g9mxQJ/ALldirRMe4QBeNskIjyDa+7y24sURSdLETrsB1jcHS8SXuhQDNeQxj8Mx012P
         VnBZaozzNw2mrhktqllYWmhCuIPeE/AXUBRwwRffiOzlfON4Ltbm3+wAY1HMPbB06ljR
         Uf/emA/I6sIjVM6I1GNlQHvPu27X/WLfVufxTl8Iz/N11qwv3Ga6Zx+azX189uwz0l/j
         URCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795597602; x=1796202402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KDTgAMo9MoGmI6cUP6xYgmRM4jfbNullnyIPniAfJY4=;
        b=PHTD2E0c+OKbNJ/DHXtTVQ/qtgMH3TwF8SVnZjkqpYNl+Bwqv7LptS5SXFAGjlQHmK
         k+U/Q1W1GVH89kCLib+APAZXu2Jze72n0jqjejt/IGm5lPdW3I14OyO+r6A1fuw/1g8l
         3QXIhgeoJdpKWbhlmV914qGLVRmdyCnOezW2X2gbmSqkgvq5R+9DEMEfcI6SISOyrQi3
         UPh3o0OEECy0df+o00u02PfjcxaccSjmip6bdW5s0Q1vT6p2tn+ugR9B7qj9vxUJJdWn
         PsEaGICoF4XaSkMfIFHSCK625dLwYLFMRgTgJ8ncEa9+y8L/DF9gfU2w6guUeDTivlkH
         NPRg==
X-Forwarded-Encrypted: i=1; AL+hErFTUPB69dSktKleUYMYRX/fk7t3B+BW2mjf/oApVfWJoNMrgeLAOOhlxZ+Zj/+FGcrr1OFhc2c=@vger.kernel.org
X-Gm-Message-State: APuU4Z9KljPKnClUIc+HHlc/Tj0QQ4gvjTxsZD72KRlOWd4h8UcE2u9r
	qcY6PKwJ9nrjGaR2cgRk0QhDet7ssqpB+nDfilsg/QKpMQS6aucn66Vj
X-Gm-Gg: AZFdTZd9b9QmPg5cOziGQkjGAhJkkdbd8EQSUFPktDs/v5jIPwFijNX4V7fqJVjU0dv
	/seiLJz+7y769eD3UK+lwK3n7HBN0ksBWto3cNCIDSEbD2mKRvp3ZrbCJE1lO4dn5jS2izX7CGt
	/822fcu1XurRBR8y9NUybLTa9Y8PuWswUSWzsdq1U4oRRrgtwIwdm2myuOcrKRVq5LaLEnkABj8
	qbmjlQajCZBLt8BKjlwoJc5bxzabamymw1GqfbnGN7HLXRznzmr/QkHtIAuTuK6TAo3X4RhMPAU
	KdNuxjIazO4qEatwKbVTjuPKithYyg5aancEFWQXMxFiXlEL6rO4uxXidwG9p6E2fWJqpT5gZWy
	Hx4FCGaw0oBlpfn0mK1fG76unK2YlA6SSNqTQaCY/PreUY497L/hxPLG+xXY7m3I5vF0B0JNSbx
	kCcgy/bWD1RtiqqJNq+3pMKLNrsHp7mc02wTBZ5uUD/+q31uRsePYz4LCW/7JGXKx+kImSm4RQM
	CLhFpb0eqSuPW5NFMz2ABufc5qjAFJvdJnk7oR7SCON6y5XVvON29zExZwyvyfpQu0v0xlvYatm
	zz+EYVgTKGFxFMdHaKtmfLc0ESxviB9uw6wiRgPrSxSVoBE5/ThwyA==
X-Received: by 2002:a05:7300:f0c2:b0:386:688:7f25 with SMTP id 5a478bee46e88-386068880f5mr17261988eec.18.1795597602408;
        Wed, 25 Nov 2026 01:06:42 -0800 (PST)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385d2b93dd9sm58712596eec.24.2026.11.25.01.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 01:06:41 -0800 (PST)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] HID: intel-ish-hid: Allocate hid_devices for the largest device count
Date: Wed, 25 Nov 2026 17:06:33 +0800
Message-Id: <20261125090633.1385386-3-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261125090633.1385386-1-maoyixie.tju@gmail.com>
References: <20261125090633.1385386-1-maoyixie.tju@gmail.com>
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

process_recv() allocates hid_devices only when it is NULL, with the
count of the first ENUM_DEVICES response. It then copies as many
entries as each response announces. A later response with a larger
count, for example after an ISH reset, can write past the array.

The count is one byte. Allocate the array once for U8_MAX entries. The
array is never reallocated, because hid_ishtp_cl_init() and the request
paths read it without a lock.

Found with a CodeQL-based static analysis tool that we are developing.
Reproduced in a userspace harness under AddressSanitizer. Not tested on
hardware.

Fixes: 0b28cb4bcb17 ("HID: intel-ish-hid: ISH HID client driver")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
v2:
- Allocate the array once for the largest count and do not reallocate
  it (Sashiko review).
- The subject changed with that.
- Shorten the commit message.
v1: https://lore.kernel.org/linux-input/20261123092816.2200718-3-maoyixie.tju@gmail.com/

I used an LLM to help write the harness and this patch.

 drivers/hid/intel-ish-hid/ishtp-hid-client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
index d1eccdc37e7a..0837af243904 100644
--- a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
+++ b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
@@ -128,7 +128,7 @@ static void process_recv(struct ishtp_cl *hid_ishtp_cl, void *recv_buf,
 			if (!client_data->hid_devices)
 				client_data->hid_devices = devm_kcalloc(
 						cl_data_to_dev(client_data),
-						client_data->hid_dev_count,
+						U8_MAX,
 						sizeof(struct device_info),
 						GFP_KERNEL);
 			if (!client_data->hid_devices) {
-- 
2.34.1

