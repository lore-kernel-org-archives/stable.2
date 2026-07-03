Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3AD3D7D70
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 15:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783091838; cv=none; b=kFAw99Qg9VWj5ZCo7xFmnIIyH6F+CP/7co00b7TXcp7ynZnactUd+AE4FaRxJJPBzAcwD34uhW0wXtcdoSSfigRsLnf1796H/EgCebr/Ys5T3BkPR3gNKUAuy5KdrKeAXVvwZG0KC+5H0eTNJn9BcauE5AAknh6e6ZjX8bLUvyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783091838; c=relaxed/simple;
	bh=K1OY5zdM6OEN9fIZJQfz8FC5tyVYrDLdL1WqwSsIcPc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iX5UzRo5rJZ/KAsmU3JUo/PnUFLyTD9uC5LFr5FibMdpYiRjNcpuN21EPsw4+ldJxTZQdx2yFNertiWU1dUs9HpuRJOADwRneStmARki4Kdabo06DWrDnwgatBh3kos9KJy7SRoM/AKAPzJVQqdnc50jl6u9qEpDSBHCySaakGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I48RFdLO; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I48RFdLO"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-493c556ada3so106955e9.0
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 08:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783091835; x=1783696635; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pl3+RrSlv3/F/20nNGvlpUqYwKsTuCaqWMZ1BmqCvGY=;
        b=I48RFdLOIMYR1ZCZmqRreuOguQ5SpCktwOkRUKWwlDwTTwBQyaH9BrINnM+JRhW8vq
         F8rA7aZvWvdOk+2HvLwBV5LYlby5fZMeZp2c12lmHO20wJtWUdOfb9KHsRDkzzfTkGZx
         MsfsovrMJ6tgKRRl6YCC+gqwyziLQw70y/lxjqM9eeIvt5+qvTE89AH7pJG7KasGVMvs
         /Jpu6IlKbwzThVvXXqGWUHmTXDYTmVcIRumvHy9YFUsmOsI07B6wwXScHbNwly+JIYCM
         HGja5b/8QYme8kIhBnAalQqGR/10BAZ3103SrBDJFrTsUjU/nRgUnuV6pub6yoWayiJY
         5pNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783091835; x=1783696635;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pl3+RrSlv3/F/20nNGvlpUqYwKsTuCaqWMZ1BmqCvGY=;
        b=bGK+VeWb8k96HHU0Ut/sXcOnhMk0MLRXGaLf3GO+6yKp0RbEQ01EVm6xdc/DP6tzxf
         384jQo18JKQ1u5JILmyhf6nfAq5vDUef01xeMiRX3Ypml1ZGHnk6e8dBSB+67PpgTX71
         aFnhzbvp7Nn7pFZ2BhNT30ZNC44e61q9LtKMhNH1aBicENj/nQgbJsrX6wm+AsiN/eHq
         to7hLNQc+zoyCW9uk+jXaYGQsGerC7XLJmdgoR0k3kXbYb/DQPb9IOX5OC3diZ2cT+EH
         QAIxpepmkWiIcw4AMzjXu2H9PnDhAAxnvXcWTRbyX1qTxWp71bHDEGxXGRXDqipOdT0v
         jV5Q==
X-Forwarded-Encrypted: i=1; AFNElJ+ze1FB9ID0vedkAf7Hwncny7cLJU9eP+5YSP3eycWnwlT8oIMK7iYiUjlVZsfWLG6eud1lFss=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSueivq7n23UxRIep/DQG0Uk94AlIqYVbXGi8OEaAKeCeh/oBg
	xutbGkjj0ePvrmMa/aCATPnN13EsdxATjL0bHURxVPtANQpqG5McIjs1SEseMdD3Ig==
X-Gm-Gg: AfdE7cniB1kzMZ0eKzPAiD/18Tf9lh1yoQwsnOGj4wPbqCO0bdUp9R5eCBOHRyxZa7z
	d33vnJIfS1N3gsFKyKaFeQrRCS0OA1ILhRHNmp4AkvFPtjrFT7b0B6+rrC/k8ZbEr0x9JZR6u6G
	SYnHOfLZkR1I5KQKz4X2iYsgVFPRRiuAAYc1kgcung0tYsWAdG90taTqWirnXw/hltLUJA5YI/J
	swYlJXI1TPov/d9rXy2K7xitL7DeP6k2uSkLgugj+MmQ0q7h/AXdhaZ40Au0IZMJVePntNEGNQH
	bXn0t1W1I0nxZ8RVHEuspwsLSzq4i31e2ZIXsvRubmCctsQXbzq/rFmZrtwyoSU4dfLmCnuOM3A
	5V+ubX8dqMpiu8j1cAygFY7R4VkcPKVaRmCa/7xWjHOzZrmnaQLv3vkRN3uvaT0HNs4bXTzERPG
	/07FURVmyOXc9AARIUVXZpY0BaTnki+79hhL5N9QSpgdEcB+hoOxPX1fh9AnyfxFi8cAeIWPo=
X-Received: by 2002:a05:600d:6446:20b0:493:b279:6012 with SMTP id 5b1f17b1804b1-493d0fe58b1mr23715e9.0.1783091834470;
        Fri, 03 Jul 2026 08:17:14 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:c0d:89b8:4c51:d7de])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493bf11eba5sm143481595e9.0.2026.07.03.08.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 08:17:13 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Subject: [PATCH 0/3] hid: fix missing hid_is_usb() checks in three drivers
Date: Fri, 03 Jul 2026 17:16:46 +0200
Message-Id: <20260703-hid-usbcheck-v1-0-e80259ff625d@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF7SR2oC/yXMQQ5AMBBA0avIrDVpiQpXEQvG0CFBOohE3F2xf
 Iv/LxDyTAJldIGng4WXOcDEEaBr5oEUd8GQ6MTqXKfKcad2adERTqowNiWLvdUmg5Csnno+v11
 V/5a9HQm39wH3/QAQFqI6cAAAAA==
X-Change-ID: 20260703-hid-usbcheck-9163e6cf6015
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 "Luke D. Jones" <luke@ljones.dev>, Miao Li <limiao@kylinos.cn>, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jann Horn <jannh@google.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783091826; l=760;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=K1OY5zdM6OEN9fIZJQfz8FC5tyVYrDLdL1WqwSsIcPc=;
 b=ZTFnHOYKP6v4nUghkdCwMVQ+kEASuNa8un//sNMk8aGmBQuJKy66d8zuStKDBo3Nkck68FfGH
 qKJi5WuMhoBDWoa53oFhUgTyhtynCPW3Y4pTJLJ1eLeS8UE8/KfKth/
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

This fixes missing hid_is_usb() checks before to_usb_interface() in
three HID drivers.
I've split it into three patches so that they can have separate "Fixes"
tags, hopefully they are easier to stable-backport this way.

Signed-off-by: Jann Horn <jannh@google.com>
---
Jann Horn (3):
      HID: asus: fix missing hid_is_usb() check
      HID: huawei: fix missing hid_is_usb() check
      HID: rapoo: fix missing hid_is_usb() check

 drivers/hid/hid-asus.c   | 2 +-
 drivers/hid/hid-huawei.c | 5 +++--
 drivers/hid/hid-rapoo.c  | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)
---
base-commit: 51512e22efe813d8223de27f6fd02a8a48ea2323
change-id: 20260703-hid-usbcheck-9163e6cf6015

Best regards,
--  
Jann Horn <jannh@google.com>

