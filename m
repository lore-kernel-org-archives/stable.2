Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F61492E52
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 01:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788916568; cv=none; b=pPM0a1JcCiUhBwt784MNsihQfpAnWB8IWs07h+2AGO9nlpzpu65L4VUqJkTpKCZ9fi0hMSIgYXGTV8h2bz5+nFWq9on00Z2f0le82iq9QtMOhG9NilIzAF11XJ01iMYGt52XEQjCMdTyIz4eRsXcxO5A3T6o+YD1oOHTtovN2GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788916568; c=relaxed/simple;
	bh=hpzfr5kjTGPkHegncW20yvavAdx/YxzgfTqNOkbXlWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G8uAtRvPLwac1QvxGGlCf4et2MOmBjnnr/Gs95AqCqpdJYclrP10j1tb1/DeHw0VzOkS6DLMuI93HzkQ+agfTPf7Oil7QXD8hf4OOnwpS9bVF2/L4/JgcaQW5UcuUIVEHOwABV7gTz3T658M98qaAx1mrlOXUxHF2WXbZOf+gT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9MsjPY5; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9MsjPY5"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d58efc7356so67299065ad.1
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 18:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788916566; x=1789521366; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1djv0lADg3+5bfdctytbSYxJnlVTWuvq8HJ74XYnhSs=;
        b=S9MsjPY5nAHASK0B6ysG+0H4AL0hflZeIFXIgWJWOX1ErbBB1/AGYR/827G9YUKeH3
         3w697WYbBz90hDiwx/OenJkBNnBVHilNwPQaPOT5np4lMC0aUbJPwN7gdJ3l84KJelGw
         vSKVAsXS/7WkaWP1g0hgkZdWwQNCkjX5okWQT+jr6vrEZthri2PxttzaEOKbau9oO3TQ
         cLjaG5mDp6rmpnWSOZ8ZhzhebuQo9GDiwXSw62t30VZoEiEoooNmfjx90TfVejweIEUp
         AVtWmt4RbXbP2wbDyJ6CXm8G/tPtDbjEZGr3vB5KHe4TsEwhFHDqzn3GckHCuqoUvR3h
         GGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788916566; x=1789521366;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1djv0lADg3+5bfdctytbSYxJnlVTWuvq8HJ74XYnhSs=;
        b=PPAg+ewpoTBz7T58OgRcFGHKnsLatLmwx0KANy+CDZ9liT1kQ5EldNgqtY6NMbJ8QS
         BqebhEqC4fYGaUZmWH+dE1Zi7pFtEStohftCYMZmqkaal/H1upKYXe+zae2yNpyRFajs
         EmKdLOVzJSS6pXzUnjMo0W7sMI+aOayJ/l9XNJTKVa1THEdzaEvTkS/Z+Nns0CejwOkN
         V5PHuKeCFIeNMu9P/EtfhV9n6bzan9OG61ZmzS6WD0KcrnD5YF3ZvLCCEWuhWtN8N25f
         ZHkfLRlfohcgFcWmUOG6HozSLDWG045Q0Y4BPOwRob4MjJSlRwNJ4iFVXuUs319pW1Ma
         1R+A==
X-Forwarded-Encrypted: i=1; AKwUvBx9CTug0y9x8KAM+LCEA0a5YrzUeTVzonl0qlS/H6JIBUsC4WEUhC+cuzNWQTju0hPCBb2Hzek=@vger.kernel.org
X-Gm-Message-State: AFuF++nwgRcfNJ2xJFpjr9EucETfQ5H75i8mCjjn1ZenlAcPUf/AESY4
	rlXrKHrZn9xsFXrFuZcvd1+nzsftLCOMWlp1L6cfenyfKl9lbtjI4oez
X-Gm-Gg: AYBFou3Xp56h0aVZEo3joeUxD2kxW3Z1jPfVif0sLxVNi7VwSAcSbKf3W4L4dCMyHzT
	O+ZgMZhTWNAdHxbn8uHIpCp9z1rKIw4Bn2gzWqZcJRR206bYiQmTW2QhWtuIhg1oIR5fVghK9Dl
	qD/jK7Z7vzY5iR2h2Ny/cQANM/DaCnF9RJI1ncqm6thaeGS2nG1H1WJU6/BmjZCiaH6Bu9TruuC
	RHZxiPEvp6Y67odd5eWEEESVEWJE7s6g3MBNiXU5JZeUEEvQiqPgVL24KXYMiXK2ZSvzyIj0aE+
	+s61n4J7fH4xUScrQUVWyJSjCB2XKncqA6QBbAuWcpLOHH6kMsgQVfaMrf+h6LBLcTtHi3eBJPr
	sHRrW7CyiSJgDEQgAnGtZr8f9TBMBLd4p1ReGCyQEKKxRQaTtLoGNfNcWUfZGVnFDiFr0Htd3b/
	4cZAXwUFR9T8+5wKri52KTMvPgpB51QRFyhvU4E/Hi2tWJ5NFyErY7NHUigauzOVF4jOzN0r5+0
	Jnp6iBEQt7UQkNsEmKhuV2Mne5S4Rd6vsw60LCqQ9jTQ4aKkvWgblyYSpjk5biyb0SaoCzJmYCi
	gRGx80o7fvAOeg6DPGo=
X-Received: by 2002:a17:90b:3b46:b0:398:dcfe:967a with SMTP id 98e67ed59e1d1-39b2620a2ecmr45550285a91.17.1788916566226;
        Tue, 08 Sep 2026 18:16:06 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain ([203.125.131.138])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39cfa2eaa92sm279074a91.3.2026.09.08.18.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 18:16:05 -0700 (PDT)
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
Subject: [PATCH v4] HID: wacom: fix OOB read in wacom_wac_pen_serial_enforce()
Date: Wed,  9 Sep 2026 09:15:13 +0800
Message-ID: <20260909011515.2314-1-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CANRwn3RFVDy+y-fpLkb1mfjiKyQgp1Jg0tyBTO+G0xem2s1jkQ@mail.gmail.com>
References: <20260828033323.82958-1-98lawweijie@gmail.com> <CANRwn3RFVDy+y-fpLkb1mfjiKyQgp1Jg0tyBTO+G0xem2s1jkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The 'wacom_wac_pen_serial_enforce()' function may calculate and pass an
invalid offset to hid_field_extract(), resulting in memory reads at
incorrect addresses -- possibly beyond the end of the report.  If a
field in the HID descriptor lists more usages than its Report Count
actually reserves space for, the function's inner 'j' will walk past
the end of the field:

	for (i = 0; i < report->maxfield; i++) {
		for (j = 0; j < report->field[i]->maxusage; j++) {
			...
			value = hid_field_extract(hdev, raw_data + 1,
						  offset + j * size, size);

A descriptor listing 12288 usages against Report Count 1 has the loop
extract the usage at index 12287 from bit offset 98296 -- about 12 KB
past a 2-byte received report.  The value is stored in
wacom_wac->serial[0] and can reach userspace as an MSC_SERIAL event,
making this an information disclosure.

Clamp the loop to field->report_count, the number of value slots the
report holds.  Value slots past the last declared usage are still
scanned; they reuse that usage (HID 1.11, 6.2.2.8).

Verified on v6.12.105 with a UHID reproducer: a 2-byte report from
such a descriptor trips KASAN before the patch and not after it.

Fixes: 83417206427b ("HID: wacom: Queue events with missing type/serial data for later processing")
Suggested-by: Jason Gerecke <killertofu@gmail.com>
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Assisted-by: GLM:glm-5.3
Signed-off-by: Wei Jie Law <98lawweijie@gmail.com>
Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>
---

Changes in v4, per Jason Gerecke's review of v3:

 - reworded the opening paragraph using Jason's suggested text; 

 - picked up Jason's Reviewed-by

 - no functional change: the diff is byte-for-byte the v3 diff

Compile-tested on 6ba2c27cb9aa (x86_64, wacom_sys.o); the runtime
verification used the identical wacom_sys.c built as a module for
v6.12.105.

v3: https://lore.kernel.org/linux-input/20260828033323.82958-1-98lawweijie@gmail.com/
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

