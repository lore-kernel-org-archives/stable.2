Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2805623A564
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 03:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787888037; cv=none; b=njXRnqNey94zvcf3DlKWznGSRR8pRJc9u1EgoG/gpymQ2fdhQ7Icd/Nns3RFIC4WppG/YH1HqGSw6yBzA6iCPVr2ZmtYJYAE02xC0zM91XjCfKsmaQY3urX9fBvLPBpjlL13biiJWBPCYdLLmXOH0eZ82YGIXycmA9g8cXqJrcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787888037; c=relaxed/simple;
	bh=O3W5OLmm62pgM3CpEscJNvH3qzmki9b+xvjyTSf3kDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dNCALyZmAi0SYcsUrPtUmIFqyIQqnH29Uys+S92ok2LQWm0k3FG6FXnJiWVjpacaqWjZIW8qGzmPKcvgADXD+C3x2TlM871tLAqhFGOC60H37fsjQi0KvvDQxVAeferELsS5dRYmrUVu5tgXkwTwlHAbcUn6ctdJyqgKCPTytMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4JJH539; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4JJH539"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cc1cf287ef8so367559a12.3
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 20:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787888035; x=1788492835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z2kWriAmVnRHA0BfpSMWspXCORRWDebvQgjhpMlIH/M=;
        b=P4JJH539rleEnVHOnsvJayV1l7Pa0KoLHxg15S1UMQYmPOrAboYOmLhQM37GIZaCyw
         rAdWgsXzpdUv6knad1o++llKqQYe7c6yqygqdt+6zLT86+YORESFiPerxSTzx55KMRHJ
         +IGsL441UPiRYVgyzDoZXF4LhK69oe7v55/b0+AWUjgrpj2ocAhIvmKNxFCgr0Sec9U+
         INXCUgYlaNpiOC1YBo4YcslwLnQq1qMbH3qJ8a6s6fT0Qs3ed+3jbyCVq7J+kmzrvdVv
         HQ8hAluCl77iv/Infl4nj/FIGIO7cbRPcE6lLlclKPdgrAXvmPXWvwYIHdkvxA0gTd9e
         6DyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787888035; x=1788492835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z2kWriAmVnRHA0BfpSMWspXCORRWDebvQgjhpMlIH/M=;
        b=KtgRfvQ3LwQAtFCOuF4L8ViR+Lutbp3fYSPoJtyr2EmnLbTQsYGQpfIlEYzJBUVCqR
         UU86GIiKQmETKPqiT0yGJ+9gi5nbuvW0KP50i7THAbdkL2mQdMoqNzWJqCzV/aXcoHxj
         TJcTWSNz+qSWiQo0FouJGaCvFGQwu6pmJQL7bZWMeNzd9H88FdWTVRDyjAaIApOpPqyi
         8aWsM2cDazqfZyhMM8zZ6ra/Qxuf413yZSyu5PbRbOiXAaRQzKwwpYdptOBQGCLb04U8
         cnspf1f7gCFfOR/GzDXDzYn+wpjPlN06G3ylJg8jgGPxzmMmWajzc9x4PTCejtH2YFuj
         rlzw==
X-Forwarded-Encrypted: i=1; AHgh+RpqxAHXCw7f8sH6Bg5v/EdF1kWjvRHYZZ53cN1e7fqvy28TCheQ6wy4MezxZoh6D7jsYtydYzE=@vger.kernel.org
X-Gm-Message-State: AFuF++l+zIlCI5AACZHr5NMN4oUfeiRdpVylPZIlBxVGru0l9rZ4bxLc
	n4UsMrIHI8BgKDAqIajOIKtuVPoa3iQGRooB7nB7fa2uuq8AZ4q6rr7V
X-Gm-Gg: AR+sD13JXprd/ZoH6KQQkCORgnZVrNQqY3mqhCweSDx0BpboOfV1W5rTFD9iA69kc6w
	ZfdQBcUsJby/znUXu/qX5YPJ/HFZ5fU+akhg5EMYl6LVzugaLAlFswBbxP2Ev9r+gC0tqGv46a+
	gHkjOTVCvsdqAjZekez6t3b0NgktpLstrAaj0svSYpruEGcJfzRRD3Y2Yuu1Uo/Uue5dtgNaos+
	RBZ+wLSSNDoCPjMZDBRH2S7jaXLSFrK2cXunew3vd2e/Cwb/773sYPbklI6HljBlsnwH/KJ5wPu
	ro3TNrwZ3+qODzph0/7H+RdteFz2CONPJ6Qzxtx8WKLiPjGdqeuECTwYb4z7w634T8+ViE3Lkg3
	B26TB87DlndDFsvgF6DT0SsGKkwsRzBrQF+r+r29O8ELSXnWXgGDWDgvRsQG7ADPC8F0IRWjcwq
	qHUrq19EdndCTJruUf6OmzwwWyo7xEsjROI29qAQZPiT6ubyw2cjW5z9MihygjgaszshvPuKhgb
	/883QIUsGjgtuUV9E6CIxoiUZ6ktaHc6kmy8VknNpZR0c3Aug2wu4gKPqrYVSLO3moquJ1Klw==
X-Received: by 2002:a17:90b:1d05:b0:396:65dd:4093 with SMTP id 98e67ed59e1d1-396d0ff519cmr7783691a91.14.1787888035408;
        Thu, 27 Aug 2026 20:33:55 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain ([203.125.131.137])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396ddca5bfbsm695369a91.17.2026.08.27.20.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 20:33:54 -0700 (PDT)
From: Wei Jie LAW <98lawweijie@gmail.com>
To: Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jason Gerecke <killertofu@gmail.com>,
	Wei Jie Law <98lawweijie@gmail.com>
Subject: [PATCH v3] HID: wacom: fix OOB read in wacom_wac_pen_serial_enforce()
Date: Fri, 28 Aug 2026 11:33:23 +0800
Message-ID: <20260828033323.82958-1-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CANRwn3TWTHxP=ZEpgZzjRweC8vqifoi2koKgSQTEuPuY4FZxcQ@mail.gmail.com>
References: <CANRwn3TWTHxP=ZEpgZzjRweC8vqifoi2koKgSQTEuPuY4FZxcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Jie Law <98lawweijie@gmail.com>

wacom_wac_pen_serial_enforce() iterates over a field's usages (up to
field->maxusage) but indexes the report bits by j * report_size, the
position of value slot j -- and only the field->report_count value
slots reserved by the Report Count exist in the report:

	for (i = 0; i < report->maxfield; i++) {
		for (j = 0; j < report->field[i]->maxusage; j++) {
			...
			value = hid_field_extract(hdev, raw_data + 1,
						  offset + j * size, size);

hid_add_field() sizes the usage array with max(usage_index,
report_count), so a report descriptor can declare far more usages
than its Report Count reserves room for in the report.  One listing
12288 usages against Report Count 1 has the loop extract the usage
at index 12287 from bit offset 98296 -- about 12 KB past a 2-byte
received report.  The value is stored in wacom_wac->serial[0] and
can reach userspace as an MSC_SERIAL event, making this an
information disclosure.

Clamp the loop to field->report_count, the number of value slots the
report holds. Value slots past the last declared usage are still
scanned; they reuse that usage (HID 1.11, 6.2.2.8).

Verified on v6.12.105 with a UHID reproducer: a 2-byte report from
such a descriptor trips KASAN before the patch and not after it.

Fixes: 83417206427b ("HID: wacom: Queue events with missing type/serial data for later processing")
Suggested-by: Jason Gerecke <killertofu@gmail.com>
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Assisted-by: GLM:glm-5.3
Signed-off-by: Wei Jie Law <98lawweijie@gmail.com>
---
Changes in v3, per Jason Gerecke's review:

 - reworded the explanation: the usage array is sized for maxusage;
   the descriptor just declares more usages than its Report Count
   reserves room for in the report, and the loop trusted maxusage
   over report_count

 - bound inner loop to field->report_count

The reproducer is available on request.

Compile-tested on 6ba2c27cb9aa (x86_64, wacom_sys.o); the runtime
verification used the identical wacom_sys.c built as a module for
v6.12.105.

v2: https://lore.kernel.org/linux-input/20260825103104.12090-1-98lawweijie@gmail.com/
v1: https://lore.kernel.org/linux-input/20260822120926.153849-1-98lawweijie@gmail.com/

 drivers/hid/wacom_sys.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 0eafa483b7f7..40770affdbde 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -113,8 +113,9 @@ static int wacom_wac_pen_serial_enforce(struct hid_device *hdev,
 
 	/* Queue events which have invalid tool type or serial number */
 	for (i = 0; i < report->maxfield; i++) {
-		for (j = 0; j < report->field[i]->maxusage; j++) {
-			struct hid_field *field = report->field[i];
+		struct hid_field *field = report->field[i];
+
+		for (j = 0; j < field->report_count; j++) {
 			struct hid_usage *usage = &field->usage[j];
 			unsigned int equivalent_usage = wacom_equivalent_usage(usage->hid);
 			unsigned int offset;
-- 
2.43.0

