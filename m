Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793569878;
	b=qpSKygcQxRDv4mXzu+5AyDMd0TarH5VfuzwvFrJ1z0mBRKZ0/fOxxapR7li7LxKgJDN0
	 O9V3/3E3QALVTW+Lhq7xVmLPbtpYfuzKnROnHWpsgr7wmGIpuefvt3PjLuRnNUz95Kym0
	 iyqn3lVvVuMWP4Q0M9gKjiWnEfdJcY5hZwuywVL9yMogX0H9A01gAOjnhlFkEJFcOzuzT
	 90oeIlYa16PrwOAB9KZHi8Dwcnn99P7HcZyB9CFP2tKsnLWhrWfZsvdUvDjv23qkb7DHX
	 CKsRIy1jcQBshvnZ9QPt7+9+dkycJvWHihzDXV0ewJNSay6/Npwwg+ddKFdry96WTAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793569878;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+fFwfLqRK9JmViO+Rr59prjwvHp0VxvmW/Io5rw0BcM=;
	b=EsLtjZbgF/ZSsXcLNomRmOzDDhdAKd3u2sMypAyB0vcnFHtGpNMCqSzuwQfGEtzb9K7w
	 UamEnM6TE0ibIa5L2Jiairi2GdKPkCoFxDTNzVMgNFc/sNLrBb8Y4UgwrUKqDr2I6A70r
	 nhYb8cG8gXdIxLuLlqUo+ydodFDs+XSAK4PqHmh44zGdaToF2C7HPXUZzydslnTtjznHp
	 JAb5kqBYDYZXFU7VUkTQ5bt1vzzqNmv7GYl8Oqr7RnnusHhIBRm+2qPh5ZI4zOWt0B8Wb
	 l0ZI0LEMh3tQf2dGid0vABlSiO018Ey8Z13Yx+QB9k75qEDJBGzfNSz/rux88JblhHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=arA3dOZ8;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB678606A337
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 21:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB678606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=arA3dOZ8
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a214af2076so17478345e9.0
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 13:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793569876; x=1794174676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+fFwfLqRK9JmViO+Rr59prjwvHp0VxvmW/Io5rw0BcM=;
        b=arA3dOZ8Qw5VaeKLI9WB4WkUoRVxRsRcmtnwspOBQgut4M22YR8KAmSIgd2cy+jpqy
         nwAVawvJFXB/kMP/qyNmfF2akNs2OZlAS3y6ohNQyqmWgSZPkC76adbAOOLFpGVJSaMb
         cMa865WRNln0vyvb9mu1VtPQd7m6AJWlpnpCV4GqxkcxQkY+WsJI3ufPtgRsJeDGbYPq
         Z2QgXVCdAg/LYfIrWvDjiBNvcxFuIMFYyU0yaOdhJs+uNGxvwyiB1hEUfLNkJIJwn5lw
         qe/mw3qptH76Z36WdpUH9XA377yLNbK/+piYbdM74y3HfU+IeAAvI0ndDsTy8j4VDQGp
         iXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793569876; x=1794174676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+fFwfLqRK9JmViO+Rr59prjwvHp0VxvmW/Io5rw0BcM=;
        b=gmtmhSs/RJX3MU74qcoU5DeVukXL1jnOaQdvaJhc1uhqHeQ1unMwQehWbjahHRwD0m
         hekdTpIH45GmUeXal8x6m4krY8tWkQ6DIDyTGQstwd4qVeqZEHmJB0w0eVUrCHmBJbbl
         smBT1q35dVXi+XkTWaxY3GkX36OSJZmUPGTkRnw3tko1q1Gpk44tVXKOlpTLd0wowjrL
         dECamjthfToNiaz0Y4l+VFBXr4RleNrU1GLZ8HwuhnYgIuvemQOkAxbbU2QUFfvRdm3W
         MEkx12QiretQF2Bh7QfKwXgmXORByB6wIZ/xOF3WtbWxMvg8rmr4LgIZLz4K1cJQQ/cj
         9icg==
X-Forwarded-Encrypted: i=1; AKwUvBw5Uig2qERGBNiWT/eWBqqY7raqCtvbGznCQG3IDBIHhN50j1qQXbXJoQWOlNA8bLY2Fksh7C8=@vger.kernel.org
X-Gm-Message-State: AFq9FYK9rj4b4BMFo+2g0EzIFu847C094r6ilQ9IXFRL5CwPVI/kv1Ld
	d7bUgy3aJW8ZXtV+Z9slkmur2+lnCgJ51EF1LJMaDYyZfmtgDhPHCsmGmMAl
X-Gm-Gg: AYBFou3/PGQrKjfxRPh9jHjM+O7gi6kIJT9qOaOj7qSCj1OJBujASUNpFYkBkwzD6Ck
	+dWDrHoG3jMy9zOLXNBJQ2EKkStLKKbyP0rIdKp4kgnrX7LDTzZp4pUxYfVRWLWFOju41z516Hi
	C0UEoH2cFGissBFeagHqgd975d2LjWfbP32Qzn6QfSrRaoAmAzxG17UsNSAvy9RAG0ZCiSjwaF3
	+/BJbvQ+TsYIxV3MgBZn2rmh30PPex8+t+sm6u9/Y0GTv59aplEne1SK1T7/tpDe3T9Tjnke7sa
	GeG1SgjbFo4FtMKDeLVZBP93dx4qIcEa/Vkchds6r8C0OX3xgcKcaSqrEQWi97sA0+0p+VeSsR6
	O5/zYeJHbNROOGYdCeyexl4pQuy0Y2fgwrd3zQsHq/PceZWFuMEWFjTXqnB0ItqRPyEMpKvN8S3
	ejVYN3q0ue6MYutXYh00NsXz6KrzkvJL2+x3EwxYDu/t9fSsaD5eny44NiMUdjSozsVUslzu+KX
	2whRYHiHENR+whoF2bpQc9NiOYp970oYZyaFZHKCJfYLsJIVTTEmZTDGWFCrfDAY6M+V8E4IS0V
	6BiPDkGe4Cbm3MLqfdQ=
X-Received: by 2002:a05:600c:6095:b0:49e:7c8c:361d with SMTP id 5b1f17b1804b1-4ac182dc30fmr173291325e9.22.1793569876416;
        Sun, 01 Nov 2026 13:51:16 -0800 (PST)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ac09ad5ff8sm157249425e9.4.2026.11.01.13.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 13:51:15 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>
Cc: linux-wireless@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH wireless 2/2] wifi: mwifiex: validate sta_count in AP sta_list response
Date: Sun,  1 Nov 2026 21:51:12 +0000
Message-ID: <20261101215112.3199197-3-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261101215112.3199197-1-tristmd@gmail.com>
References: <20261101215112.3199197-1-tristmd@gmail.com>
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

mwifiex_ret_uap_sta_list() iterates over sta_info entries using the
firmware-provided sta_count without verifying the response buffer is
large enough to hold that many entries.

Add a size check that validates the response contains enough data for
the declared number of station entries before iterating.

Fixes: 8baca1a34d4c ("mwifiex: dump station support in uap mode")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c b/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
index 85512f526c5f2a..4d8493f9a6697e 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
@@ -973,11 +973,19 @@ static int mwifiex_ret_uap_sta_list(struct mwifiex_private *priv,
 {
 	struct host_cmd_ds_sta_list *sta_list =
 		&resp->params.sta_list;
-	struct mwifiex_ie_types_sta_info *sta_info = (void *)&sta_list->tlv;
-	int i;
+	struct mwifiex_ie_types_sta_info *sta_info;
+	u16 sta_count = le16_to_cpu(sta_list->sta_count);
+	u16 resp_size = le16_to_cpu(resp->size);
 	struct mwifiex_sta_node *sta_node;
+	int i;
+
+	if (resp_size < sizeof(*resp) - sizeof(resp->params) +
+	    sizeof(*sta_list) + sta_count * sizeof(*sta_info))
+		return -EINVAL;
+
+	sta_info = (void *)&sta_list->tlv;
 
-	for (i = 0; i < (le16_to_cpu(sta_list->sta_count)); i++) {
+	for (i = 0; i < sta_count; i++) {
 		sta_node = mwifiex_get_sta_entry(priv, sta_info->mac);
 		if (unlikely(!sta_node))
 			continue;
-- 
2.47.3

