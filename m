Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794412311;
	b=B3vbCLM7NFdSuzIn/Fql8LnTVYeNrcq2BEeMXVhxz2wz3vNtM34Px4qtZNtTxbsbJqlE
	 /6U4QpuzmBKWmkL2w6Lp+BDjb7M3F2OUgBgIhdaKNBM0rMUONIWDlX2AEpyloj7SsWPI/
	 F539MM5um6K6/EQCHE8ZHsPM5FcrPUPftBADY9N0eDQYYwKN0vls/lzVgOC32Quhw87ED
	 jlem/r7EpbWma7nAKiT0ij+9lyXFYToQL98FsBtBQFP1+jtyy7OAz75JDLY8HcB+ewQuI
	 d+/a1DlDIn3MeeinFkOiaaZ6VyJBTe9AMKwKQeC6HRGD6JibYBKRdorLPiGe46MS/oA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794412311;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=ajehow2AaQjjAzQ/E5oG9jXQaN9GSNMVZ551qeRPCo4=;
	b=oj+oAR7Ly1azPE4ZW1RpgC4SE0XNQ8O01AGtlUTznWmkwC5MHI44BKwTrY1SrOgSYtz6
	 uB8IQWo7pHsYsQbKowrNNAyyfPUS252rjAjWQXMNo5Tj8ohX0m9J7pFNDdsUC8YXVed+L
	 gCPi4Lhd/p7JuRPo5atItsU7cm5ru78SRw5RH3K6jf1o5p8uwVSa7fXTI/N9qqYsD3joD
	 Kd+MXzEGop1j1XoUsSxSQ/htxh8wEqyHhmOxdnsUyxc48BrP7C2iDFrgWurdi5DXbIRbJ
	 ITaEfFJsoLSP8a+SIsEOnYf2+zp6xQuR9Tb2obRwMTmKVeAmfG8RH1TYj9qKnJ9DFiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=PIOhD2Bp;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96548606A324;
	Wed, 11 Nov 2026 15:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96548606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=PIOhD2Bp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=ajehow2AaQjjAzQ/E5oG9jXQaN9GSNMVZ551qeRPCo4=; b=PIOhD2BpuEIm6G/FXpPOqHGgmd
	umlCRMHoPa55dXcmVcxiAO7WKBwOD+Pn0KIDQnV/PibUc7YRpp+62kYmiwRI8DHm3D4Czmibsj7h2
	CIf0xGjF11BXJLfNG3f3vxlY2giFDRgikfmHYfItA2l0CcKbzF0BqYvpd+DyaZl/3k1V3r8nGe78a
	S2eugsVrAS1l3qCmTcKXZfQte7oIQt/S/uC1qfNZbqPSIhTRLbDb6QBLK03TVXSZ1Jjphs3FNHiwY
	VlIXXe7nnGG35whf416lIJsjC8nAIzdoUR+XFCjyxrJCir68jRKhMeMX6/MYNYuTyvg3Lp5WOuOyY
	dvZVQWbQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xRAbo-00DI4S-1X;
	Wed, 11 Nov 2026 15:51:36 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 11 Nov 2026 07:50:01 -0800
Subject: [PATCH] ACPI: APEI: Fix ERST record walk looping on a missing
 record
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-erst_missing_id-v1-1-ac12ba315d3e@debian.org>
X-B4-Tracking: v=1; b=H4sIAK2O9GoC/x3MYQpAQBAG0KtM329bu0J2ryJtYjA/LO1ISu6uv
 AO8B8pZWBHoQeZLVPaEQK4gjOuQFjYyIRBKWzbOOWs46xk3UZW0RJmMb+1YNbOvfW1REI7Ms9z
 /2PXv+wFXRg+YYQAAAA==
X-Change-ID: 20261110-erst_missing_id-980c46f95950
To: Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Borislav Petkov <bp@alien8.de>, 
 Hanjun Guo <guohanjun@huawei.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, 
 Liu Xinpeng <liuxp11@chinatelecom.cn>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, stable@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2884; i=leitao@debian.org;
 h=from:subject:message-id; bh=SIHyJQHKyvaAFSXY/tZiveKejd9Lb29HTM5WVoeOV+c=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq9I8DPz4gFoY/m/TaQxX9K4ElwX9Imw3swgTAS
 X9P47J/su+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCavSPAwAKCRA1o5Of/Hh3
 bQ/PD/4ueDY0cAA3U1hUtwT9hkomx6iGsk8ZjAgeRaWlybQyFxFUxWYCGaJhBgGvySuwuoXRnwP
 aMX/y1lNWBGaYykMQw7sxddKm5stm0OZVsyssJLuMw3krXmuUhlLOSy4fz/7D4HXIOjA9eb+EAY
 DrBj3xBCXwttX4/Peg862nRNZJD+LRHfdsoSdIy4dlipQgL2Z01QAl+tg45I1KiyBLy54TuWG8O
 lmqCqltXQraIEqmVG+r99eCo/z0/ITFTGgkGGm5hO4pANN805TvClflgSsnbA7zeQoOwXj2N257
 CFoK3OFsh+9heYEZsGrWyDwc78gns5Xd6TqbeWUTRZYyoH7rH6e4ks+Rsp955haTs/53LiI/iCd
 9XF3V3XuibkddCmX77iLgV1BWQHP4mkVcA+zTQZu93LmBZCeehfPKjOwQdMtRGppJRaNblniq5N
 IgpYyoqYwrZVMBypKaOcW2EDQj9wrp/GxCt8EJPhAAQbLY38p8zjrMxls9g1piHiLIzDboaKWFt
 Oyosw2oCwEGBj2/EIajAy1znUUAfdD4N9330YKEFhD+mhrHIdN+30pJe6AA6Au+OS35k/520nWr
 s48dEc3l5zoYCvxqEa3l92MgNIDlH9rWTSHnwqGqrwyf2E3hlhmkOFaBgMWcklv1pRQZFto1jHY
 DVHHvNn8xTccXUg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

On some x86 servers with AMI firmware, mounting pstore logs

  ERST: [Firmware Warn]: too many record IDs!

and /sys/fs/pstore stays empty. The firmware keeps returning, from
GET_RECORD_IDENTIFIER, the ID of a record that READ reports as not
found, while GET_RECORD_COUNT reads 0.

Since commit a090931524d0 ("ACPI: APEI: Fix missing ERST record id"),
erst_read_record() drops such an ID from the record ID cache. The next
__erst_record_id_cache_add_one() call no longer recognizes it and adds
it again, until the cache holds ERST_RECORD_ID_CACHE_SIZE_MAX (1024)
IDs.

Remember the last ID that read back as missing and skip it like a
cached one, so the prev_id check ends the walk. Forget it once the last
walker is done.

On an affected machine, each pstore mount goes from 1024 failed READs
and 297 ms to one failed READ and 13 ms.

Fixes: a090931524d0 ("ACPI: APEI: Fix missing ERST record id")
Cc: stable@vger.kernel.org
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/acpi/apei/erst.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index 50c98db57e4a5c..0e8c52326d82fc 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -457,11 +457,13 @@ struct erst_record_id_cache {
 	int len;
 	int size;
 	int refcount;
+	u64 missing_id;
 };
 
 static struct erst_record_id_cache erst_record_id_cache = {
 	.lock = __MUTEX_INITIALIZER(erst_record_id_cache.lock),
 	.refcount = 0,
+	.missing_id = APEI_ERST_INVALID_RECORD_ID,
 };
 
 static int __erst_get_next_record_id(u64 *record_id)
@@ -523,6 +525,10 @@ static int __erst_record_id_cache_add_one(void)
 		first_id = id;
 	prev_id = id;
 
+	/* The firmware may keep handing out a record it reported missing */
+	if (id == erst_record_id_cache.missing_id)
+		goto retry;
+
 	entries = erst_record_id_cache.entries;
 	for (i = 0; i < erst_record_id_cache.len; i++) {
 		if (entries[i] == id)
@@ -639,6 +645,9 @@ void erst_get_record_id_end(void)
 	mutex_lock(&erst_record_id_cache.lock);
 	erst_record_id_cache.refcount--;
 	BUG_ON(erst_record_id_cache.refcount < 0);
+	/* The next walk retries it, a new record may reuse the ID */
+	if (!erst_record_id_cache.refcount)
+		erst_record_id_cache.missing_id = APEI_ERST_INVALID_RECORD_ID;
 	__erst_record_id_cache_compact();
 	mutex_unlock(&erst_record_id_cache.lock);
 }
@@ -900,6 +909,7 @@ static void erst_clear_cache(u64 record_id)
 		if (entries[i] == record_id)
 			entries[i] = APEI_ERST_INVALID_RECORD_ID;
 	}
+	erst_record_id_cache.missing_id = record_id;
 	__erst_record_id_cache_compact();
 
 	mutex_unlock(&erst_record_id_cache.lock);

---
base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
change-id: 20261110-erst_missing_id-980c46f95950

Best regards,
--  
Breno Leitao <leitao@debian.org>

