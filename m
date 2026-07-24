Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DBD3B3BF1
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 20:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784925216; cv=none; b=qmyZ0rF702YoX/XPSr75LSrrUSPwj0/Qkam9mvWH4DoWAM6aFMIxxaN0IZ0Ep4nqwflpT8F3N+MxGJX6azNRNLZR2iH7+QkaWiJTf/ZoXFpusINbAG7ozvU7zbJbl5cAD3x4ntrZ9ijbYqFO18GQ+SB1+q8AsZ7zY0hUt0wluHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784925216; c=relaxed/simple;
	bh=Zk/sFfO0P3Zc5xIDecphI5VF2UB8/fuN2Q0noue8ons=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=inYcVIhi77JZb0rg+ahfoX/V9y1krLASa7XJrkvZcMg/hRgf/hBuE6Q5xKjf2Uhgug/HeTeyVmKab93TTqd0KVLWP95l618VswoYi2SNwKtBC+ft2Ga20sXgVvv8tI4AG/h15/1lQnqmrf8UMpyG2LIoTXifvowgKO4jklrMRBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HhvCEONQ; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhvCEONQ"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-385ea3ce80dso902637a91.2
        for <stable@vger.kernel.org>; Fri, 24 Jul 2026 13:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784925214; x=1785530014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PqO55og8W7BHslOf6Z0mSPTkO0lYXWtdruA0wlaytcE=;
        b=HhvCEONQHnbIk9gAobdXUbHrILlYRqwWyrmFpksA4NKb2I2Ypq+I3tLjDNNoTmMKTR
         zDqfbde5wRJYLSzH24C5kf1ehUGdPWFgDmDgYG/zx5f8o4IQIVXFevQ0zVePJERJDF4e
         DsMr+w9PoldTPeSjU2T3TekW6O8634sDOGHxbimEioNJvYufFK0yEDPy8vpYHwXCSPsR
         W4xLpD11E1rN0lXc6khhL5rYIG7ihddup/eSAC6lQ/iCGyx5jjii35WjKYNk6tISl53Q
         2kVCPpahTCFFEO/JAbZo25wQHFlXvNvg+BOML3MYprNjlzEr3O1KShEOET/oM6zPR7i9
         h1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784925214; x=1785530014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PqO55og8W7BHslOf6Z0mSPTkO0lYXWtdruA0wlaytcE=;
        b=Fg11slX6kcvS327jQNTNOdECfQ0CeX/0/WG/mKPB6u3fSJqBs4Xt0UmCEmYxRWg0px
         HPK642eYABsMW95gdWSlYGyJFggq/f3DTDH3jtkbk72iUc21oBiZNLk7XVkFPjUcYN14
         jyHDSC847yK0a0ZrDg2RJRsthvI+WrytbaX66/ZlmJZ3QgS8sFvszUABeLPUkMzOTTPH
         ZWK9FEeqABxoheJANfvoOBKnHs07nLieu+nT+7RSXfD7zdTfSjJ30bukROVQz3+6UWoA
         Y8+AXjvja+3PiDsDB8xkEiTyzmlzv5+ZFMYJMhhsXMP4Gpz/A5NQX6cjGBph6e1SGJmu
         D4aQ==
X-Forwarded-Encrypted: i=1; AHgh+RqtO2G6Z7uTwqDLknyFl2gwnPZ/cc4SPFpkOmWs5Ms2WvAKtK2DKLCY4t3ZZo08QcuWuz0f5N8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlUG7OoOts1hEj7PF84qYdjMUfDzDRK4H7c2XzSW1SSGnOFzP7
	SmdIIsC/xFaqnBVXgkF8I01iAx3Iq8c6SkDqlm7Z91MZU33R8/vji2U0
X-Gm-Gg: AR+sD12BtKkRbhfaW/9R9tvb7bXUAh0LBVDbLdlCHQsCwKJ7b315nPSsQWEJI/ZcMDn
	+gJc8cB0mfYfz2uRZsFb9Rcq7VqiZFz/IUDtLezoqG8euPdQ7rAndvpBENqxS66z+Brz7i8/K/H
	q3nUc31wsKYGy6Dxcut4/llexDUduvECBJ1b12+eKUQaczmCH26ZTWGqupWWJqoqnml4gd1qqsv
	SxozHRIt3Ru/YR3HJN88UL5y8PnOzXCscDRrPvLbQqLKTC2qIN0ZwSudpp/8giOQ1jkGpJnKTkb
	gO1YxwCPHqBMNiQNzCKcTM9xXlYI7bGNl0ZdTVSU8lce2NmjuONkpcZHSImpW7BJR7Nt3TdP/YH
	kQAow+3uUlA5WeDBiqtCajPKGEd1DnXOiRrjsRNlQ+WlOv27AS7x4hl1NXWSPUPeAErNd8V/Zw6
	syO8GclhBilEFZIZQxJ3rxBipn2YdPOz+ogkG9fh2Ku2jTToVwkgg=
X-Received: by 2002:a17:90a:c890:b0:38e:dc4:3fbb with SMTP id 98e67ed59e1d1-38ec68982femr8118870a91.43.1784925213668;
        Fri, 24 Jul 2026 13:33:33 -0700 (PDT)
Received: from fabio-X870-EAGLE-WIFI7.. ([2804:1b3:a801:60b4:ddf8:a4ba:150b:5c93])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d13003f12sm48918684c88.2.2026.07.24.13.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 13:33:32 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: johannes.berg@intel.com
Cc: briannorris@chromium.org,
	francesco@dolcini.it,
	linux-wireless@vger.kernel.org,
	Fabio Estevam <festevam@nabladev.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] wifi: mwifiex: Detach sync cmd buffer on interrupted wait
Date: Fri, 24 Jul 2026 17:33:19 -0300
Message-ID: <20260724203320.78793-1-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@nabladev.com>

mwifiex synchronous commands keep the caller-provided data buffer in
cmd_node->data_buf. Several callers pass stack-allocated objects there.

If wait_event_interruptible_timeout() is interrupted, the caller can
return and release that stack object while the firmware command is still
the current command. A late firmware response then reaches the normal
response handler, which can copy data through cmd_node->data_buf into the
stale stack address.

This fixes a stack corruption observed during repeated association and
disassociation cycles. The panic trace showed the command wait being
interrupted immediately before a bad pointer dereference:

  cmd_wait_q terminated: -512
  Unable to handle kernel paging request at virtual address 002c583837384662
  Kernel panic - not syncing: stack-protector: Kernel stack is corrupted
  ...
  Tainted: [M]=MACHINE_CHECK

The fault address decodes as little-endian ASCII:

  0x002c583837384662 -> "bF878X,\0"

which is a fragment of the VERSION_EXT firmware string exposed as
debugfs "verext":

  w8997o-V4, RF878X, FP92, 16.92.21.p153.7

The same runs also showed corrupted control data containing:

  0x2400372e333531 -> "153.7\0$"

which is the tail of the same VERSION_EXT string. This points at a late
VERSION_EXT response writing through a stale stack-backed data_buf after
the interrupted wait returned.

After cancelling pending commands on an interrupted or timed-out wait,
detach the caller-owned data buffer from the still-current command. This
preserves the existing command cancellation behaviour while preventing a
late response from writing through a pointer whose lifetime ended with the
waiting caller.

Tested on an i.MX8MP board using an 88W8997.

Cc: stable@vger.kernel.org
Fixes: 3d026d09b28d ("mwifiex: cancel pending commands for signal")
Signed-off-by: Fabio Estevam <festevam@nabladev.com>
---
 drivers/net/wireless/marvell/mwifiex/sta_ioctl.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
index 9460d5352b23..19196848778c 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
@@ -57,6 +57,18 @@ int mwifiex_wait_queue_complete(struct mwifiex_adapter *adapter,
 		mwifiex_dbg(adapter, ERROR, "cmd_wait_q terminated: %d\n",
 			    status);
 		mwifiex_cancel_all_pending_cmd(adapter);
+
+		/* The command response path writes through cmd_node->data_buf.
+		 * On an interrupted wait, the caller can return and release a
+		 * stack-allocated data_buf before a late firmware response is
+		 * processed. Detach the caller-owned buffer from the current
+		 * command so a late response cannot corrupt freed stack memory.
+		 */
+		spin_lock_bh(&adapter->mwifiex_cmd_lock);
+		if (adapter->curr_cmd == cmd_queued)
+			adapter->curr_cmd->data_buf = NULL;
+		spin_unlock_bh(&adapter->mwifiex_cmd_lock);
+
 		return status;
 	}
 
-- 
2.43.0

