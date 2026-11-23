Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795426105;
	b=Nbe3FRn6CSJPisVniPvpemCo21LCqyL3A+XVHVr7dRH4I0pWT3ZyQVtZ+Hj4Y0fDipQ/
	 14UP62hq54xoEe8LjuNWXkZ9KeW8g6DUbJiElgSqD124Ma17Z1mso8bwvE72jxCKXFdhM
	 /jLV/7oqEkOeRM4LwYgakcEw3oLshb5grGhxr0AvqMtwTK7jmeZLySSTH8Kh32zQLpRU+
	 +tA9NiYCiLC9ts1ltkn85ez4SRI/AlDmNpbboThdmgMxU4DLKJ5rHUpA+WMKB5Y3G6Z8l
	 e7D875y+1Q/bk0HHnqj75VgMTAEjNHF7q+v+PlUml//93xf8OuNMxabX8K/7A+Y749Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795426105;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=2eqY5M+833O7wLNRlvkDeBl1muWO4amje1VZmhdt6f8=;
	b=gFaAz09UnU3BE8UzM+vumhLTiM4vyCwDvvbgwzh1P7+yUqCt7exFPjAnS7dslIVLEkaq
	 28312SeLRRzLtFrjv0PKe9SB/8YW4ddcIPbsZvjFZMJ6BFvTJFQGm9EHeQg4c0gBmT6m0
	 UEiNnJAV7u7+bDyi/zPjrzRlz/qdQUr3tEdCdij6HVMlaSuMO7r6xBVjxPf+GzjKXxfdo
	 J+1cVCz+AFYHfVqu0mR5axMKcxQfzY+RWR+wDVlTGbyz3ov14OnZ8mXOgADQTiuc+RoDx
	 JuXUwllk0fbABZsDZeYWN3Lv9yqqDmtaGDJcyTyloG6Tno9rFFaWo8cTfT+CH6AFglw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KonRzl74;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CCF606A338
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 09:28:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07CCF606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KonRzl74
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1ae58d17cd9so2837393c88.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 01:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795426104; x=1796030904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2eqY5M+833O7wLNRlvkDeBl1muWO4amje1VZmhdt6f8=;
        b=KonRzl74XuVsyONQ5BC9tePVp835nCUourDadESPVPQNurQGyV0Gg6QkRUt2wlQP9G
         bTgRQkGYczWbaCIg+dfrxapDzGftCnZjr8CxMlgKn4BUX+khuOubhAUoTViRNfpxKT9m
         pFLCIqrvaJ0taIH/faDWUGp+G9kYi7TMxxsTJWY/OUuwWl71t/iRDDpDdpOn6GQouaSI
         Gs16HE0tyLWO+R4H3Xh//oXf7Oohy4Ee4a3kk5go+j79u2HmPV3/ayV5LsInYCGvVICe
         ZZN4hrhzq34bYZElaj1GuCi1BkmRy46KBtjYV/9xFt9xNQuvTOMHR6/Fe/MTox8mdqob
         MS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795426104; x=1796030904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2eqY5M+833O7wLNRlvkDeBl1muWO4amje1VZmhdt6f8=;
        b=xPx6ODmgfq07MT/12rE/mykgaYf6eW5tKMfRM+yFLh2GjlAaUyfrbVeQOw+6facm1v
         uxLfKk5DLTUKtsuBHstLcuJBJup7V2es0PvXbJxcosDFxlu422PcY3jGAAf9wMONoJJZ
         EdjHq4YJ6WPWtH9Kprgq/xxnhz2g43SZB6ZfT4OJO12r3S3qyd/nUwG022oY+PqDCiPp
         xI4jfU4iW+30hTCQY9RkW5HqbV0+Xns5ldAfsBq19tbeo/egl3u5RJjfFXp9T5195wyl
         vEX6nJg3Fv0E85rs5MzHIU3tQzIJm2t3o43GuNB7hWq9+eQOXSq1TgOcxAumR1+g/xb5
         ARRg==
X-Forwarded-Encrypted: i=1; AL+hErEE65WniBzaR6oQTKZEDTVBbC8jv2pFPd+45my5Q+b3KqMzlllbas4DWx087/nbu6kTKQR44hA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/yJRcVFFB6BONfe06BQQRGbi5fB1bJdjX3wZRNjPQEyVIFogVM
	N+SfefdC+h1GsKutbHiifKhGnCjRmPU2K2wBHg9EF1uVzJRgtitKyRf3
X-Gm-Gg: AZFdTZfU7N37r3KzF1lOLBbPTGuz7YCa9GeNYZTnw1/bersyPrnOgY5zDlgIXyVNtsd
	xPQHT5i5rv2HOFwvzdrXVTslJoE1cO2TM1vKj86+ccAaTmriXbWaT9fSO1HUN5qF/UVHfKz8uht
	mH6qWNsFpUEvn5nF7M/2gHxOJAUDj26ZEQjoxlFgJ6wz7kSLUqPsmBXoIL5O1O9Rx0GNQr48vGT
	YmJ0vLVvo9sYfqH8gfvUVXipXeDtW8m9vg8BI+yEIMX7e6pli8zTks/8UL0wXhTx8l/bZ3aMcNB
	lx6QBMKI/4gPl5bIysrbuLrz9E+x7Sacd8MpjjIef6sx4fUTsJFw4X/8vPnGvKTqQjasnAV6CzY
	tvLi2/zDKjQdWYEt3xqagf1jkMWF257a/Pbwlyu1BDH61ydqOXV6uRMR5jew0Np06VkIhALS1Z/
	QDaqFimA70sWC69AoO6qeNHlKvGZkD+hqH5Tmh6986Zk3aOUh497IlnZD8ZnNgPG1geGdHjxaAb
	CQdiZeFQh5HdQ3CLOLJoQ4PdQr8wPZKgr3QwQCPCYUzfvwN4qeMqVB8dbm7fCyZujUKrVAfFm+I
	Hg3Jd/OGjpysqOwETuzHPtcX/QsiLJADuTNFsrSUL3vQqoceZZouMQ==
X-Received: by 2002:a05:701a:cc91:20b0:1b5:7148:95b5 with SMTP id a92af1059eb24-1b571489632mr2871767c88.8.1795426104066;
        Mon, 23 Nov 2026 01:28:24 -0800 (PST)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55ff0e4e6sm19861941c88.11.2026.11.23.01.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 01:28:23 -0800 (PST)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] HID: intel-ish-hid: Reallocate hid_devices for a larger device count
Date: Mon, 23 Nov 2026 17:28:16 +0800
Message-Id: <20261123092816.2200718-3-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261123092816.2200718-1-maoyixie.tju@gmail.com>
References: <20261123092816.2200718-1-maoyixie.tju@gmail.com>
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
entries as each response announces. After an ISH reset, a larger count
can write past the array. A second response with a larger count does
the same. After a first response with no devices, the next copy writes
at ZERO_SIZE_PTR.

Size the array to the announced count with devm_krealloc_array() before
the copy, and update hid_dev_count only when that succeeds. A count of
zero keeps the old array as before, since hid_ishtp_cl_init() may still
read it.

Found with a CodeQL-based static analysis tool that we are developing.
Reproduced in a userspace harness under AddressSanitizer, which reports
none of these writes with this patch. Not tested on hardware, only
compile-tested with W=1 on hid.git for-7.4/upstream-fixes.

Fixes: 0b28cb4bcb17 ("HID: intel-ish-hid: ISH HID client driver")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
I used an LLM to help write the harness and this patch.

 drivers/hid/intel-ish-hid/ishtp-hid-client.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
index 24f4032d6dfe..864a06a7bd3f 100644
--- a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
+++ b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
@@ -70,6 +70,8 @@ static void process_recv(struct ishtp_cl *hid_ishtp_cl, void *recv_buf,
 	unsigned char *payload;
 	unsigned char *descr;
 	struct device_info *dev_info;
+	struct device_info *devices;
+	unsigned int count;
 	int i, j;
 	size_t	payload_len, total_len, cur_pos, raw_len, msg_len;
 	int report_type;
@@ -124,19 +126,21 @@ static void process_recv(struct ishtp_cl *hid_ishtp_cl, void *recv_buf,
 			}
 			if (client_data->init_done)
 				break;
-			client_data->hid_dev_count = (unsigned int)*payload;
-			if (!client_data->hid_devices)
-				client_data->hid_devices = devm_kcalloc(
-						cl_data_to_dev(client_data),
-						client_data->hid_dev_count,
-						sizeof(struct device_info),
-						GFP_KERNEL);
-			if (!client_data->hid_devices) {
+			count = *payload;
+			devices = client_data->hid_devices;
+			if (count || !devices)
+				devices = devm_krealloc_array(cl_data_to_dev(client_data),
+							      devices, count,
+							      sizeof(struct device_info),
+							      GFP_KERNEL | __GFP_ZERO);
+			if (!devices) {
 				dev_err(cl_data_to_dev(client_data),
 				"Mem alloc failed for hid device info\n");
 				wake_up_interruptible(&client_data->init_wait);
 				break;
 			}
+			client_data->hid_devices = devices;
+			client_data->hid_dev_count = count;
 			for (i = 0; i < client_data->hid_dev_count; ++i) {
 				if (1 + sizeof(struct device_info) * i >=
 						payload_len) {
-- 
2.34.1

