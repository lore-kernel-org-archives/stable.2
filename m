Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74973CB2FE
	for <stable@vger.kernel.org>; Sun, 30 Aug 2026 17:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788110645; cv=none; b=Xx18HVxrwsMIasmrIkIo3w8R9P0S7CnTB+VHHUTrXr8QOhHHX0q1P6e8s4RGD+W3O0zn4hQ8ToML3wYsV2RY+N+j7dw2c7Fno6SgE4J0SUK1NaXic+i9qPbMB7CyZTev6+4eIn1vwBKLGTHUHkTC2pLXSW2/rzDMMiaR4m1GOC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788110645; c=relaxed/simple;
	bh=xxVeXb4jvY5cuRDXjZpM6wV0C5NoiUzvvPu6TV0iLAI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F1d67qsDBsxm39ECJksTptUzQLJ9bw32nuD3CXBoSZJKDCxCmFNG9SPP8Ib9m6he45KY3cheYL0hluQuRHJovmVt/Cn9Pax+VPpPTRA+tXfURFJ9t9db14uogTPestCavKDB/Mp/QxL0oumi90g+n+5RjLRR+86dowxaG/HvlX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s7Eu25XY; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s7Eu25XY"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5c67175d176so1169470e0c.0
        for <stable@vger.kernel.org>; Sun, 30 Aug 2026 10:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788110639; x=1788715439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=auiga5dFUTaRf1HhrjsnmsIoHm0d18F433OVE3MYWfc=;
        b=s7Eu25XY005g4Bh8GUVADaU45cKm9KpV7PhLe8TLjX7zNt5/sZntMSTaPvxdjpc8zd
         zASR3WzXkrX6QJa3OgQ9wJn1Fjp+7dEGCRQHDHPN/WH6xIcJAQrZhJprLui8tWxIuPes
         rux7KIBFjofh2AK/HgaFg6NN+Ezy2ii6XwSjlNbNpON+Cmd7WqDzlc5KJmBxIPmSJaCB
         /VQer2wixh3IO4NLwRRYcY4nruDRulTXCb7aAmx9OT0sThuNcr99zHISOQvazgmUTVoh
         6m8McZLJyEk8Y4OH7k94jayeLE6Z8UPBr0lWJ5Mo+/SFfulSjX96ssdcCpY6RXIDV7PG
         yJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788110639; x=1788715439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=auiga5dFUTaRf1HhrjsnmsIoHm0d18F433OVE3MYWfc=;
        b=CMc8ShqmYdn7e4MlkbgxUWPgFjeF9X+Yrd+ROOt1UbPXNx3CGncaBg2I+zs5VIQE1L
         ujo3Tx1EjF+LAbKP39O/s9PVna8bbFVw9JnoYnr8YqvmUBitPw/zRQ8zFVlKA0e2/3bS
         ISsKLdGiTktlrnIJwTLAORhp1jwbytAh+b/81Hmpyd8hRdU+a3ot0ylor3ED0FWZV9FV
         utVAtTk8MuMr/gFCuH5w0ZLeBvQlSpAa/nLvnYKoW4qkLn7av4Nbc8XlKTwNMkZHWbBq
         cHjQgOxRVN9GQsMfixxZ6EXn1Z60t60o8qdtPDKQLbac4ZQ8JjMlovDdEvS8bMdZm95h
         At4w==
X-Forwarded-Encrypted: i=1; AHgh+RoPaQs10JZoxu2X2pP/fROlT1Rb3JMDKwU3sgDWTQ7nYONr7lHLfFSFm6Ja68c5bqOU0i4CS8A=@vger.kernel.org
X-Gm-Message-State: AFuF++lKiAdF5Ev0G3Q4EicUyDzRYtsCOry4lWH/FtBduMphVWy+1h03
	uxaveLr1OwOshEJ7OD9hB+cmpVwj/x5IrL36POTTpP3mHpZDI5IuGIEx
X-Gm-Gg: AR+sD12BbwzGHPKxQwbejkkqq96hQHpjmTOoR92n47/orqQyAux1XM92YZXA+a3BBg/
	rICNx2m4Nr6v/vtS35SCvwUZKtwsamxOHd36lvGLfLdnVmDlaeA6ZNwvMCYFYCqsiIUpONCqF0v
	LrTSTULMqlZEd7eP7ORqcocfMzHlZ1UYGAtp9Mr10qc30yZiTZrDOYLDnX8n90Q5JsWtQwCrUon
	uMJ6MiQNbWeaabLw7o2nsGVidtU8WZl/D9NxueBFptPDjK9ct+G2+gmLswe7ck5OdTJYNpn9nd6
	o5W66mAOna0dt5rrJLinNQbQzAHVn/Zk5O4BS1Zo3l9l7JaFe17nPDSCPKhltq5MW2NstpgAZVt
	XZ0N+/eJ+B/HlntVBOPyYdGmrABnbzSiey+AvBTkq/nMetNHBTbqjnagZULx0SIjByJGQRsnf6e
	68gP1rGLMQ1YLFU323jHzygagXuyk6ciZRgbR5GBDlox5SnvVy5FZ6JTPCneD3b0nMoRqXU0Qi3
	de36V0=
X-Received: by 2002:a05:6102:5cc6:b0:77d:ddec:3ab0 with SMTP id ada2fe7eead31-785977fef72mr5953151137.6.1788110639188;
        Sun, 30 Aug 2026 10:23:59 -0700 (PDT)
Received: from alessandro-rzn2024.. ([2804:ebc:9070:7a00:c574:bb1e:fe2d:77bb])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97ea3cb16d9sm1223354241.8.2026.08.30.10.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 10:23:58 -0700 (PDT)
From: Alessandro Menezes <alessandroasm@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hans Verkuil <hverkuil@kernel.org>,
	ye xingchen <ye.xingchen@zte.com.cn>,
	Alessandro Menezes <alessandroasm@gmail.com>
Subject: [PATCH] Revert "media: siano: Convert to use sysfs_emit_at() API"
Date: Sun, 30 Aug 2026 13:23:30 -0400
Message-ID: <20260830172330.3395671-1-alessandroasm@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 2f7d0c94396e ("media: siano: Convert to use
sysfs_emit_at() API").

sysfs_emit_at() may only be used from sysfs show() methods, where the
destination is the page-sized, page-aligned buffer that sysfs passes to
the callback.  It enforces that at runtime:

	if (WARN(!buf || offset_in_page(buf) || at < 0 || at >= PAGE_SIZE,
		 "invalid sysfs_emit_at: buf:%p at:%d\n", buf, at))
		return 0;

smsdvb has no show() method.  The converted functions format statistics
into smsdvb_debugfs.stats_data, a plain char[PAGE_SIZE] member of a
kmalloc()'d struct, which reaches userspace through debugfs via
simple_read_from_buffer().  The preceding kref and spinlock_t place
stats_data at offset 8 in the object, and the object itself is 4136
bytes, so it is served from the kmalloc-8192 cache with a page-aligned
base.  offset_in_page(stats_data) is therefore always 8, never 0, and
every one of the 104 converted calls trips the WARN and returns 0
without writing anything:

  WARNING: fs/sysfs/file.c:781 at sysfs_emit_at+0x59/0xd0
  invalid sysfs_emit_at: buf:00000000fb2f86e6 at:0
   smsdvb_print_isdb_stats_ex+0x459/0x650 [smsdvb]
   smsdvb_update_isdbt_stats_ex+0x34/0x6e0 [smsdvb]
   smsdvb_onresponse+0x2bc/0x6a0 [smsdvb]
   smsusb_onresponse+0x117/0x230 [smsusb]

The statistics are formatted from the USB completion handler, so this
fires from interrupt context on every statistics response the device
sends, and the debugfs stats file is permanently empty.

Note the buffer cannot be realigned the way commit 8f48ba303dfb
("drm/amdgpu: fix sysfs_emit/sysfs_emit_at warnings(v2)") handled the
same warning: there the buffer really was a sysfs page that had been
advanced past its start, so walking back to the page boundary was valid.
Here it is not a page at all, and backing the pointer up by
offset_in_page() would land on the struct's own kref and spinlock.

scnprintf() is the correct interface for formatting into a
driver-private buffer, and was the deliberate choice here since commit
af72bc8cd6ab ("media: siano: Use scnprintf() for avoiding potential
buffer overflow").

Fixes: 2f7d0c94396e ("media: siano: Convert to use sysfs_emit_at() API")
Cc: stable@vger.kernel.org
Signed-off-by: Alessandro Menezes <alessandroasm@gmail.com>
---
Tested on 7.0.0-30-generic with a Siano MDTV receiver (USB 187f:0600,
ISDB-T).  Before: reading
/sys/kernel/debug/usb/smsdvb/<dev>/stats returns nothing and each
statistics response from the device adds a WARN.  After: the file
contains the full per-layer ISDB-T statistics and no WARN is logged.

offsetof()/sizeof() above were measured on that kernel, not inferred.

--- a/drivers/media/common/siano/smsdvb-debugfs.c
+++ b/drivers/media/common/siano/smsdvb-debugfs.c
@@ -45,48 +45,89 @@
 
 	buf = debug_data->stats_data;
 
-	n += sysfs_emit_at(buf, n, "is_rf_locked = %d\n", p->is_rf_locked);
-	n += sysfs_emit_at(buf, n, "is_demod_locked = %d\n", p->is_demod_locked);
-	n += sysfs_emit_at(buf, n, "is_external_lna_on = %d\n", p->is_external_lna_on);
-	n += sysfs_emit_at(buf, n, "SNR = %d\n", p->SNR);
-	n += sysfs_emit_at(buf, n, "ber = %d\n", p->ber);
-	n += sysfs_emit_at(buf, n, "FIB_CRC = %d\n", p->FIB_CRC);
-	n += sysfs_emit_at(buf, n, "ts_per = %d\n", p->ts_per);
-	n += sysfs_emit_at(buf, n, "MFER = %d\n", p->MFER);
-	n += sysfs_emit_at(buf, n, "RSSI = %d\n", p->RSSI);
-	n += sysfs_emit_at(buf, n, "in_band_pwr = %d\n", p->in_band_pwr);
-	n += sysfs_emit_at(buf, n, "carrier_offset = %d\n", p->carrier_offset);
-	n += sysfs_emit_at(buf, n, "modem_state = %d\n", p->modem_state);
-	n += sysfs_emit_at(buf, n, "frequency = %d\n", p->frequency);
-	n += sysfs_emit_at(buf, n, "bandwidth = %d\n", p->bandwidth);
-	n += sysfs_emit_at(buf, n, "transmission_mode = %d\n", p->transmission_mode);
-	n += sysfs_emit_at(buf, n, "modem_state = %d\n", p->modem_state);
-	n += sysfs_emit_at(buf, n, "guard_interval = %d\n", p->guard_interval);
-	n += sysfs_emit_at(buf, n, "code_rate = %d\n", p->code_rate);
-	n += sysfs_emit_at(buf, n, "lp_code_rate = %d\n", p->lp_code_rate);
-	n += sysfs_emit_at(buf, n, "hierarchy = %d\n", p->hierarchy);
-	n += sysfs_emit_at(buf, n, "constellation = %d\n", p->constellation);
-	n += sysfs_emit_at(buf, n, "burst_size = %d\n", p->burst_size);
-	n += sysfs_emit_at(buf, n, "burst_duration = %d\n", p->burst_duration);
-	n += sysfs_emit_at(buf, n, "burst_cycle_time = %d\n", p->burst_cycle_time);
-	n += sysfs_emit_at(buf, n, "calc_burst_cycle_time = %d\n", p->calc_burst_cycle_time);
-	n += sysfs_emit_at(buf, n, "num_of_rows = %d\n", p->num_of_rows);
-	n += sysfs_emit_at(buf, n, "num_of_padd_cols = %d\n", p->num_of_padd_cols);
-	n += sysfs_emit_at(buf, n, "num_of_punct_cols = %d\n", p->num_of_punct_cols);
-	n += sysfs_emit_at(buf, n, "error_ts_packets = %d\n", p->error_ts_packets);
-	n += sysfs_emit_at(buf, n, "total_ts_packets = %d\n", p->total_ts_packets);
-	n += sysfs_emit_at(buf, n, "num_of_valid_mpe_tlbs = %d\n", p->num_of_valid_mpe_tlbs);
-	n += sysfs_emit_at(buf, n, "num_of_invalid_mpe_tlbs = %d\n", p->num_of_invalid_mpe_tlbs);
-	n += sysfs_emit_at(buf, n, "num_of_corrected_mpe_tlbs = %d\n",
-			   p->num_of_corrected_mpe_tlbs);
-	n += sysfs_emit_at(buf, n, "ber_error_count = %d\n", p->ber_error_count);
-	n += sysfs_emit_at(buf, n, "ber_bit_count = %d\n", p->ber_bit_count);
-	n += sysfs_emit_at(buf, n, "sms_to_host_tx_errors = %d\n", p->sms_to_host_tx_errors);
-	n += sysfs_emit_at(buf, n, "pre_ber = %d\n", p->pre_ber);
-	n += sysfs_emit_at(buf, n, "cell_id = %d\n", p->cell_id);
-	n += sysfs_emit_at(buf, n, "dvbh_srv_ind_hp = %d\n", p->dvbh_srv_ind_hp);
-	n += sysfs_emit_at(buf, n, "dvbh_srv_ind_lp = %d\n", p->dvbh_srv_ind_lp);
-	n += sysfs_emit_at(buf, n, "num_mpe_received = %d\n", p->num_mpe_received);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "is_rf_locked = %d\n", p->is_rf_locked);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "is_demod_locked = %d\n", p->is_demod_locked);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "is_external_lna_on = %d\n", p->is_external_lna_on);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "SNR = %d\n", p->SNR);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "ber = %d\n", p->ber);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "FIB_CRC = %d\n", p->FIB_CRC);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "ts_per = %d\n", p->ts_per);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "MFER = %d\n", p->MFER);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "RSSI = %d\n", p->RSSI);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "in_band_pwr = %d\n", p->in_band_pwr);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "carrier_offset = %d\n", p->carrier_offset);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "modem_state = %d\n", p->modem_state);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "frequency = %d\n", p->frequency);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "bandwidth = %d\n", p->bandwidth);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "transmission_mode = %d\n", p->transmission_mode);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "modem_state = %d\n", p->modem_state);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "guard_interval = %d\n", p->guard_interval);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "code_rate = %d\n", p->code_rate);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "lp_code_rate = %d\n", p->lp_code_rate);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "hierarchy = %d\n", p->hierarchy);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "constellation = %d\n", p->constellation);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "burst_size = %d\n", p->burst_size);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "burst_duration = %d\n", p->burst_duration);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "burst_cycle_time = %d\n", p->burst_cycle_time);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "calc_burst_cycle_time = %d\n",
+		      p->calc_burst_cycle_time);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "num_of_rows = %d\n", p->num_of_rows);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "num_of_padd_cols = %d\n", p->num_of_padd_cols);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "num_of_punct_cols = %d\n", p->num_of_punct_cols);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "error_ts_packets = %d\n", p->error_ts_packets);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "total_ts_packets = %d\n", p->total_ts_packets);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "num_of_valid_mpe_tlbs = %d\n", p->num_of_valid_mpe_tlbs);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "num_of_invalid_mpe_tlbs = %d\n", p->num_of_invalid_mpe_tlbs);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "num_of_corrected_mpe_tlbs = %d\n", p->num_of_corrected_mpe_tlbs);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "ber_error_count = %d\n", p->ber_error_count);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "ber_bit_count = %d\n", p->ber_bit_count);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "sms_to_host_tx_errors = %d\n", p->sms_to_host_tx_errors);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "pre_ber = %d\n", p->pre_ber);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "cell_id = %d\n", p->cell_id);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "dvbh_srv_ind_hp = %d\n", p->dvbh_srv_ind_hp);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "dvbh_srv_ind_lp = %d\n", p->dvbh_srv_ind_lp);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "num_mpe_received = %d\n", p->num_mpe_received);
 
 	debug_data->stats_count = n;
 	spin_unlock(&debug_data->lock);
@@ -107,49 +148,78 @@
 
 	buf = debug_data->stats_data;
 
-	n += sysfs_emit_at(buf, n, "statistics_type = %d\t", p->statistics_type);
-	n += sysfs_emit_at(buf, n, "full_size = %d\n", p->full_size);
-
-	n += sysfs_emit_at(buf, n, "is_rf_locked = %d\t\t", p->is_rf_locked);
-	n += sysfs_emit_at(buf, n, "is_demod_locked = %d\t", p->is_demod_locked);
-	n += sysfs_emit_at(buf, n, "is_external_lna_on = %d\n", p->is_external_lna_on);
-	n += sysfs_emit_at(buf, n, "SNR = %d dB\t\t", p->SNR);
-	n += sysfs_emit_at(buf, n, "RSSI = %d dBm\t\t", p->RSSI);
-	n += sysfs_emit_at(buf, n, "in_band_pwr = %d dBm\n", p->in_band_pwr);
-	n += sysfs_emit_at(buf, n, "carrier_offset = %d\t", p->carrier_offset);
-	n += sysfs_emit_at(buf, n, "bandwidth = %d\t\t", p->bandwidth);
-	n += sysfs_emit_at(buf, n, "frequency = %d Hz\n", p->frequency);
-	n += sysfs_emit_at(buf, n, "transmission_mode = %d\t", p->transmission_mode);
-	n += sysfs_emit_at(buf, n, "modem_state = %d\t\t", p->modem_state);
-	n += sysfs_emit_at(buf, n, "guard_interval = %d\n", p->guard_interval);
-	n += sysfs_emit_at(buf, n, "system_type = %d\t\t", p->system_type);
-	n += sysfs_emit_at(buf, n, "partial_reception = %d\t", p->partial_reception);
-	n += sysfs_emit_at(buf, n, "num_of_layers = %d\n", p->num_of_layers);
-	n += sysfs_emit_at(buf, n, "sms_to_host_tx_errors = %d\n", p->sms_to_host_tx_errors);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "statistics_type = %d\t", p->statistics_type);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "full_size = %d\n", p->full_size);
+
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "is_rf_locked = %d\t\t", p->is_rf_locked);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "is_demod_locked = %d\t", p->is_demod_locked);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "is_external_lna_on = %d\n", p->is_external_lna_on);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "SNR = %d dB\t\t", p->SNR);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "RSSI = %d dBm\t\t", p->RSSI);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "in_band_pwr = %d dBm\n", p->in_band_pwr);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "carrier_offset = %d\t", p->carrier_offset);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "bandwidth = %d\t\t", p->bandwidth);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "frequency = %d Hz\n", p->frequency);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "transmission_mode = %d\t", p->transmission_mode);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "modem_state = %d\t\t", p->modem_state);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "guard_interval = %d\n", p->guard_interval);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "system_type = %d\t\t", p->system_type);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "partial_reception = %d\t", p->partial_reception);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "num_of_layers = %d\n", p->num_of_layers);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "sms_to_host_tx_errors = %d\n", p->sms_to_host_tx_errors);
 
 	for (i = 0; i < 3; i++) {
 		if (p->layer_info[i].number_of_segments < 1 ||
 		    p->layer_info[i].number_of_segments > 13)
 			continue;
 
-		n += sysfs_emit_at(buf, n, "\nLayer %d\n", i);
-		n += sysfs_emit_at(buf, n, "\tcode_rate = %d\t", p->layer_info[i].code_rate);
-		n += sysfs_emit_at(buf, n, "constellation = %d\n", p->layer_info[i].constellation);
-		n += sysfs_emit_at(buf, n, "\tber = %-5d\t", p->layer_info[i].ber);
-		n += sysfs_emit_at(buf, n, "\tber_error_count = %-5d\t",
-				   p->layer_info[i].ber_error_count);
-		n += sysfs_emit_at(buf, n, "ber_bit_count = %-5d\n",
-				   p->layer_info[i].ber_bit_count);
-		n += sysfs_emit_at(buf, n, "\tpre_ber = %-5d\t", p->layer_info[i].pre_ber);
-		n += sysfs_emit_at(buf, n, "\tts_per = %-5d\n", p->layer_info[i].ts_per);
-		n += sysfs_emit_at(buf, n, "\terror_ts_packets = %-5d\t",
-				   p->layer_info[i].error_ts_packets);
-		n += sysfs_emit_at(buf, n, "total_ts_packets = %-5d\t",
-				   p->layer_info[i].total_ts_packets);
-		n += sysfs_emit_at(buf, n, "ti_ldepth_i = %d\n", p->layer_info[i].ti_ldepth_i);
-		n += sysfs_emit_at(buf, n, "\tnumber_of_segments = %d\t",
-				   p->layer_info[i].number_of_segments);
-		n += sysfs_emit_at(buf, n, "tmcc_errors = %d\n", p->layer_info[i].tmcc_errors);
+		n += scnprintf(&buf[n], PAGE_SIZE - n, "\nLayer %d\n", i);
+		n += scnprintf(&buf[n], PAGE_SIZE - n, "\tcode_rate = %d\t",
+			      p->layer_info[i].code_rate);
+		n += scnprintf(&buf[n], PAGE_SIZE - n, "constellation = %d\n",
+			      p->layer_info[i].constellation);
+		n += scnprintf(&buf[n], PAGE_SIZE - n, "\tber = %-5d\t",
+			      p->layer_info[i].ber);
+		n += scnprintf(&buf[n], PAGE_SIZE - n,
+			      "\tber_error_count = %-5d\t",
+			      p->layer_info[i].ber_error_count);
+		n += scnprintf(&buf[n], PAGE_SIZE - n, "ber_bit_count = %-5d\n",
+			      p->layer_info[i].ber_bit_count);
+		n += scnprintf(&buf[n], PAGE_SIZE - n, "\tpre_ber = %-5d\t",
+			      p->layer_info[i].pre_ber);
+		n += scnprintf(&buf[n], PAGE_SIZE - n, "\tts_per = %-5d\n",
+			      p->layer_info[i].ts_per);
+		n += scnprintf(&buf[n], PAGE_SIZE - n,
+			      "\terror_ts_packets = %-5d\t",
+			      p->layer_info[i].error_ts_packets);
+		n += scnprintf(&buf[n], PAGE_SIZE - n,
+			      "total_ts_packets = %-5d\t",
+			      p->layer_info[i].total_ts_packets);
+		n += scnprintf(&buf[n], PAGE_SIZE - n, "ti_ldepth_i = %d\n",
+			      p->layer_info[i].ti_ldepth_i);
+		n += scnprintf(&buf[n], PAGE_SIZE - n,
+			      "\tnumber_of_segments = %d\t",
+			      p->layer_info[i].number_of_segments);
+		n += scnprintf(&buf[n], PAGE_SIZE - n, "tmcc_errors = %d\n",
+			      p->layer_info[i].tmcc_errors);
 	}
 
 	debug_data->stats_count = n;
@@ -171,50 +241,80 @@
 
 	buf = debug_data->stats_data;
 
-	n += sysfs_emit_at(buf, n, "statistics_type = %d\t", p->statistics_type);
-	n += sysfs_emit_at(buf, n, "full_size = %d\n", p->full_size);
-
-	n += sysfs_emit_at(buf, n, "is_rf_locked = %d\t\t", p->is_rf_locked);
-	n += sysfs_emit_at(buf, n, "is_demod_locked = %d\t", p->is_demod_locked);
-	n += sysfs_emit_at(buf, n, "is_external_lna_on = %d\n", p->is_external_lna_on);
-	n += sysfs_emit_at(buf, n, "SNR = %d dB\t\t", p->SNR);
-	n += sysfs_emit_at(buf, n, "RSSI = %d dBm\t\t", p->RSSI);
-	n += sysfs_emit_at(buf, n, "in_band_pwr = %d dBm\n", p->in_band_pwr);
-	n += sysfs_emit_at(buf, n, "carrier_offset = %d\t", p->carrier_offset);
-	n += sysfs_emit_at(buf, n, "bandwidth = %d\t\t", p->bandwidth);
-	n += sysfs_emit_at(buf, n, "frequency = %d Hz\n", p->frequency);
-	n += sysfs_emit_at(buf, n, "transmission_mode = %d\t", p->transmission_mode);
-	n += sysfs_emit_at(buf, n, "modem_state = %d\t\t", p->modem_state);
-	n += sysfs_emit_at(buf, n, "guard_interval = %d\n", p->guard_interval);
-	n += sysfs_emit_at(buf, n, "system_type = %d\t\t", p->system_type);
-	n += sysfs_emit_at(buf, n, "partial_reception = %d\t", p->partial_reception);
-	n += sysfs_emit_at(buf, n, "num_of_layers = %d\n", p->num_of_layers);
-	n += sysfs_emit_at(buf, n, "segment_number = %d\t", p->segment_number);
-	n += sysfs_emit_at(buf, n, "tune_bw = %d\n", p->tune_bw);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "statistics_type = %d\t", p->statistics_type);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "full_size = %d\n", p->full_size);
+
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "is_rf_locked = %d\t\t", p->is_rf_locked);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "is_demod_locked = %d\t", p->is_demod_locked);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "is_external_lna_on = %d\n", p->is_external_lna_on);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "SNR = %d dB\t\t", p->SNR);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "RSSI = %d dBm\t\t", p->RSSI);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "in_band_pwr = %d dBm\n", p->in_band_pwr);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "carrier_offset = %d\t", p->carrier_offset);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "bandwidth = %d\t\t", p->bandwidth);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "frequency = %d Hz\n", p->frequency);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "transmission_mode = %d\t", p->transmission_mode);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "modem_state = %d\t\t", p->modem_state);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "guard_interval = %d\n", p->guard_interval);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "system_type = %d\t\t", p->system_type);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "partial_reception = %d\t", p->partial_reception);
+	n += scnprintf(&buf[n], PAGE_SIZE - n,
+		      "num_of_layers = %d\n", p->num_of_layers);
+	n += scnprintf(&buf[n], PAGE_SIZE - n, "segment_number = %d\t",
+		      p->segment_number);
+	n += scnprintf(&buf[n], PAGE_SIZE - n, "tune_bw = %d\n",
+		      p->tune_bw);
 
 	for (i = 0; i < 3; i++) {
 		if (p->layer_info[i].number_of_segments < 1 ||
 		    p->layer_info[i].number_of_segments > 13)
 			continue;
 
-		n += sysfs_emit_at(buf, n, "\nLayer %d\n", i);
-		n += sysfs_emit_at(buf, n, "\tcode_rate = %d\t", p->layer_info[i].code_rate);
-		n += sysfs_emit_at(buf, n, "constellation = %d\n", p->layer_info[i].constellation);
-		n += sysfs_emit_at(buf, n, "\tber = %-5d\t", p->layer_info[i].ber);
-		n += sysfs_emit_at(buf, n, "\tber_error_count = %-5d\t",
-				   p->layer_info[i].ber_error_count);
-		n += sysfs_emit_at(buf, n, "ber_bit_count = %-5d\n",
-				   p->layer_info[i].ber_bit_count);
-		n += sysfs_emit_at(buf, n, "\tpre_ber = %-5d\t", p->layer_info[i].pre_ber);
-		n += sysfs_emit_at(buf, n, "\tts_per = %-5d\n", p->layer_info[i].ts_per);
-		n += sysfs_emit_at(buf, n, "\terror_ts_packets = %-5d\t",
-				   p->layer_info[i].error_ts_packets);
-		n += sysfs_emit_at(buf, n, "total_ts_packets = %-5d\t",
-				   p->layer_info[i].total_ts_packets);
-		n += sysfs_emit_at(buf, n, "ti_ldepth_i = %d\n", p->layer_info[i].ti_ldepth_i);
-		n += sysfs_emit_at(buf, n, "\tnumber_of_segments = %d\t",
-				   p->layer_info[i].number_of_segments);
-		n += sysfs_emit_at(buf, n, "tmcc_errors = %d\n", p->layer_info[i].tmcc_errors);
+		n += scnprintf(&buf[n], PAGE_SIZE - n, "\nLayer %d\n", i);
+		n += scnprintf(&buf[n], PAGE_SIZE - n, "\tcode_rate = %d\t",
+			      p->layer_info[i].code_rate);
+		n += scnprintf(&buf[n], PAGE_SIZE - n, "constellation = %d\n",
+			      p->layer_info[i].constellation);
+		n += scnprintf(&buf[n], PAGE_SIZE - n, "\tber = %-5d\t",
+			      p->layer_info[i].ber);
+		n += scnprintf(&buf[n], PAGE_SIZE - n,
+			      "\tber_error_count = %-5d\t",
+			      p->layer_info[i].ber_error_count);
+		n += scnprintf(&buf[n], PAGE_SIZE - n, "ber_bit_count = %-5d\n",
+			      p->layer_info[i].ber_bit_count);
+		n += scnprintf(&buf[n], PAGE_SIZE - n, "\tpre_ber = %-5d\t",
+			      p->layer_info[i].pre_ber);
+		n += scnprintf(&buf[n], PAGE_SIZE - n, "\tts_per = %-5d\n",
+			      p->layer_info[i].ts_per);
+		n += scnprintf(&buf[n], PAGE_SIZE - n,
+			      "\terror_ts_packets = %-5d\t",
+			      p->layer_info[i].error_ts_packets);
+		n += scnprintf(&buf[n], PAGE_SIZE - n,
+			      "total_ts_packets = %-5d\t",
+			      p->layer_info[i].total_ts_packets);
+		n += scnprintf(&buf[n], PAGE_SIZE - n, "ti_ldepth_i = %d\n",
+			      p->layer_info[i].ti_ldepth_i);
+		n += scnprintf(&buf[n], PAGE_SIZE - n,
+			      "\tnumber_of_segments = %d\t",
+			      p->layer_info[i].number_of_segments);
+		n += scnprintf(&buf[n], PAGE_SIZE - n, "tmcc_errors = %d\n",
+			      p->layer_info[i].tmcc_errors);
 	}
 
 
-- 
2.43.0

