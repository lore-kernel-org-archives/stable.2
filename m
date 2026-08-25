Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C751F5834
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 10:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787653871; cv=none; b=hK0gflP5ULH2vdgJH07Y0NY14POcwZu/sBJv0qy0Uj5kyQrBjLZCJr73yz7yFfPZBbiDS7Mo9y4NsbWVJSfwHR1C3m3NbAA7mxuj/dBtJi5ZjGfUXgFkixdqmuDfZJsoqfpCMhNMf0E8uhz/q3+ZUkRYSVpxIIpmbW/THWCNgUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787653871; c=relaxed/simple;
	bh=/43KOMS60rSwqm+0h6nol2XjGbfCzZZdtTRs+CP2OHU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EARTzTwoYVu3/tS/8PdX3CvjAcpw4wCwwmePth+h6wBo3GB6PFByzrg/Sr1V4quL9FlThpNtqyiQWC5VJS87ulgsGe4k3Uh37GnzOwNeViolGHBn59W5FClqPXEYqYpiPvmsQyJ1UvakOTLCuiVutgv0x77BFzR7HmF9DSYkMyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzMVeBY7; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzMVeBY7"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so5459985a91.0
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 03:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787653869; x=1788258669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zHxpkdrH+ub77zWOCs0hPYLKcUBXeDslDiRjI02XCqo=;
        b=lzMVeBY7ckKUw+lV86tD3L71zaIJ/Z57diaQeYEgxLGIRKI5D+c5mjrME41KzKlzd7
         Qs/bHGeKdWMP7B+Y4AFAx59kKmOz/z+BXqQbmJ/+3++5pgnhT4vB0HNt91/tinmsIMZW
         1tSZghtynl0YRTkue9AKua82u15EW1PhoVRb7t4dMLn+N4Lc6g1RPkb/6/0XTreM0LqN
         nDfG3KkYVlIP6Wz6oFevQrC/hoh3jTLmEjZWkOgsPvY5JDM/3TpKyYcniwpU3H8v3mPs
         jFkem+AKvf52JxOaUSLOFLs37sPOqcbKoCrFzCaCDPy1rcO5r7vSlmEcAOPoZYtgOKri
         m85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787653869; x=1788258669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zHxpkdrH+ub77zWOCs0hPYLKcUBXeDslDiRjI02XCqo=;
        b=joc1Z+Q2FuMTYcJYOsyKRxexBPlZl34zR4UxaWVpRheff06UfVwYEug1SQe0yBU/YT
         pFIBlpgjFPr3ae+Juzosca3tt4h6uuo5IbCbmC5ZdohL45xonDTk94VfszjeWT10n7rz
         WCiFu23TpPogyTg5b4+gXbZ5jpszfj3lAp8QwWsQlNb/0E3ifVejF52FcRh/HGb/zlPS
         Lia6UOtZk2e2x47MxXLFYlXiEhwdwz+rv1glRdUnLFCXbRaYzUFfuOSZljG6eVADOksH
         SgZ6geuGSnGqvbX+16vICH/l/mVdKJF9HEoLrU3YS58CRoRPsK2TAkMWT29b2hDD+hUz
         Vdgw==
X-Forwarded-Encrypted: i=1; AHgh+Rp8nOxlGx+wKs+tc7ycIf0iU4nzldxgRiIGgnrjPNUR3rzTCF79yZISjKEkqVwjjgONVR7nJUw=@vger.kernel.org
X-Gm-Message-State: AFuF++n8q7kS3pW3HzZju+sZr5TYe5lDq7JJEUv6zH0zNU5tJRIfyTBO
	WnaqXlBthWMCl6GvWla5WhinCEr0G/xKlgNw+XwnKr2J0g8RLRspcP4FsbtZl01C
X-Gm-Gg: AR+sD11pUpN6bnJhBOew5QJVUnI/exD5136NWkHTP7DE/5/3CITi7XIXS+UkyNMyy1N
	uPdPN0JcKWFebfZIrVwfpCogvVI6LSuVkC+b0paMZF6+4uIoiJF6cWS9z0I9FK3QvEP8Zk5Vj/b
	Y2bRxv58nZUAVt/yy/jJF1ymsqAaF4W6S3VI+tVuvNjJuKze7IHASUwsrBA79Ofjep8tZKh29SZ
	OGINKHinoiaCBFGjGhWe2nCCbAAjXhrWZnFmiJTd86AH4/YaGYo6CNc2cD3ZcuZpuZoJFWTW5Fl
	gaeDb1sR6O1QZVbsPfqJ0d3ykV8NtGwdUVI7AyiMO3QxiLRbK2wN1dX3IAQnOhG0Lgjxb8wJ73e
	JnIeluh7jUgd0iaKd493sCO7hQ3emU4XKj58erCGWIrqDQoJWObGzC28s+oKCpfOXjg9+ibS6lB
	dRksW5IbFvzWAuccih/XcU5SJHG3O9T23ivbPCgWojxU9imre08TwVOrW6PZFSiG7y7oTHgY7v8
	p1EVxabTeD/EAp8dT1kM7nXIB84VLXl2jJS8uXchte05a9u9J57MsVxBbREKEJQtTcShq21elxz
	c03eF1L6mlE8j6LPa7C64LnG
X-Received: by 2002:a17:90b:1b04:b0:38d:dfd1:7c1 with SMTP id 98e67ed59e1d1-395c33406e0mr56047468a91.2.1787653869085;
        Tue, 25 Aug 2026 03:31:09 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645b17ebasm3358068a91.4.2026.08.25.03.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 03:31:08 -0700 (PDT)
From: Wei Jie Law <98lawweijie@gmail.com>
To: Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] HID: wacom: fix OOB read in wacom_wac_pen_serial_enforce()
Date: Tue, 25 Aug 2026 18:31:03 +0800
Message-ID: <20260825103104.12090-1-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wacom_wac_pen_serial_enforce() iterates over a field's usages (up to
field->maxusage) but indexes the report bits by j * report_size:

	for (i = 0; i < report->maxfield; i++) {
		for (j = 0; j < report->field[i]->maxusage; j++) {
			...
			value = hid_field_extract(hdev, raw_data + 1,
						  offset + j * size, size);

In hid_add_field() the usage array is sized max(usage_index,
report_count), so field->maxusage can be far larger than report_count
when a descriptor lists more usages than its Report Count.  A field
declaring Usage Minimum 0 / Usage Maximum 0x2ffe with Report Count 1
gives maxusage == 12288 while the field's bit region is only 8 bits
wide.  The extract at j == 12287 then reads bit offset 12287 * 8, i.e.
byte 12287 of raw_data + 1, roughly 12 KB past a 2-byte received
report.  __extract() performs no bounds check.

The value read that way is stored into wacom_wac->serial[0] and can be
emitted to userspace as an MSC_SERIAL event by wacom_wac_pen_report(),
so this is an information disclosure and not just an out-of-bounds
read.  A malicious device only has to claim vendor id 0x056a for
hid_scan_report() to place it in HID_GROUP_WACOM and have this driver
bound to it, and a single crafted input report is enough to trigger the
read.

Clamp the inner loop to the field's actual report region with
min(maxusage, report_count), so usages that have no report data behind
them are no longer extracted.

Verified on v6.12.104, whose wacom_sys.c is identical to mainline here,
with a UHID reproducer and with an emulated USB device (raw-gadget): a
hardware watchpoint on wacom_wac->serial[0] fires with an out-of-bounds
heap byte while a 2-byte report is being processed, and no longer fires
once the loop is clamped.

Fixes: 83417206427b ("HID: wacom: Queue events with missing type/serial data for later processing")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Assisted-by: GLM:glm-5.3
Signed-off-by: Wei Jie Law <98lawweijie@gmail.com>
---
Changes in v2:
 - No code change: the diff is identical to v1.  Adds the Assisted-by
   tags required by Documentation/process/coding-assistants.rst.

The reproducer is available on request.

Compile-tested on bd5f485f3f02, x86_64 defconfig + CONFIG_HID_WACOM=y.

v1: https://lore.kernel.org/linux-input/20260822120926.153849-1-98lawweijie@gmail.com/

 drivers/hid/wacom_sys.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 0eafa483b7f7..1ea8763b68a8 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -113,8 +113,10 @@ static int wacom_wac_pen_serial_enforce(struct hid_device *hdev,
 
 	/* Queue events which have invalid tool type or serial number */
 	for (i = 0; i < report->maxfield; i++) {
-		for (j = 0; j < report->field[i]->maxusage; j++) {
-			struct hid_field *field = report->field[i];
+		struct hid_field *field = report->field[i];
+		unsigned int count = min(field->maxusage, field->report_count);
+
+		for (j = 0; j < count; j++) {
 			struct hid_usage *usage = &field->usage[j];
 			unsigned int equivalent_usage = wacom_equivalent_usage(usage->hid);
 			unsigned int offset;
-- 
2.43.0

