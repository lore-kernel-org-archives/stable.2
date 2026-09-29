Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE012F7EFE
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 01:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790644196; cv=none; b=j3iX5J3LxW+NSzpRHF2XIlkznUuqHQ+qRTYntzXR/fFqfhDPkZEBHsZpXjmJILL8WcXPONj7fWvGWuBBYorOD5DBQ6cDMiN2PDRdtDMoGXDO+LIuk4SdjpLjC8DciuvGrRJvUtbX9kc+AvpBcKQJ+f9+gcEPVrTJT5095+Lu6wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790644196; c=relaxed/simple;
	bh=J04w6m736rx7ewf6/jKvl5BzfuXA+8hHFvMZDOWRIOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KNqwFDq4T2/s7OYz3f+nvo1TNVD2PDpkisDDOBW9iTnLb/81iEN2aSKAuRKSQ9GJTRWnQAp/FzwzZKmp3nieXYfr7AJHHDJIE4J+xlFGQM0mm75BFjUNs+TGuVGvakrCQ5dNo+sPMkxYfBCbYzmP48HUEF/GRcC3YdAwOwsV5u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n+cGfVeJ; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n+cGfVeJ"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-340fbf9c1c6so2210573eec.3
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 18:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790644194; x=1791248994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nu8Cl9d5kdkeLBWfcAAawSaGHAduQcU752rXCWMacQA=;
        b=n+cGfVeJQNoJ87Em/9OIrVWDmNkI10TvLfN2TqE9Va0jI9Syjfvf3xdmJukIhqNWrC
         LzyWD4ISqf10lK4y1tVE4jTQysATQ4MNCmpLKa4gLpSLGZYmT3X9jWbOzhlPAXOeN/ci
         OFeXW0R2sjuMU+vB6qEJ0CDpYBiklA9Crwh8gGO1uS121QbMnsNe/fMFJfVWLkDo0btt
         CDhksV7AWDtAEOU4MBU7pKR9Vxpc/it9KTMLGSRfwecHKOXMn1wtqs4+V4y5PFxDmSN/
         p3/esE9oVjq+JT9JK4DvqWmIg06HwSkgM0j2SMrSrPEaZK/dZSn3vtvuhQ1gvn/FY9yx
         8oZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790644194; x=1791248994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nu8Cl9d5kdkeLBWfcAAawSaGHAduQcU752rXCWMacQA=;
        b=AIKmr7ekzqzqgwRcoIEweFhtF+UOqK8PwNKjGgwYrRgeRAnshF2VprORZC7l4scf7q
         xG2Tc2AlnjUDyhft7iJSG7FD6Gu5CBEwrha5eDyi42p1XEdZB5akbwRdTioKBHTOKSe+
         aQjIL+FcnF5qWTyEK1fMDgZ674APM2OF/3bfiQM7rpbC94PrdCSVD/HVPn4MeClNct/G
         e5uS8O75sr/CEzx5qW1KDZwOQGyuT0HEhEq4YVK3YV8lrTCTH8EU3LA0uIbvCy7FC8oy
         kw7ke5xeV1MHb9XmHYkYFO4aTSk7+ZmIZZtjO4iitF20dmEqyZ7/P0gT8ECenEnihhaI
         /mrw==
X-Gm-Message-State: AFq9FYJ17lH+uemIA1RdV+2IB720pp6qTVyljo0nDDw8VSWaW45bOHDo
	MOraM6UAn6ItxlwifulgsVxwIpLnDiuu7ZOHxAhvwSWgOZQodtUovSuM
X-Gm-Gg: AYBFou38KzlATReOBjmaouoq8sFmZy3XKkT8T4Bic+mhKRYIFqGI8RBLjJIEnW+PK0v
	L1Vr8E1c6H2TMsOa9LnPRQxiEWHGLRimrjKPDLKvDiwZTBBtbDkahursvauFkfOyKYk/Pbzp3+3
	Ca7P9qObUoWXwAOO5A/RD6gPGy50Xdrkpm/wUotKWnW43eBDfydWjK4hLafsNQx6J4z/TamKOQa
	Ri/67gAHZFLK/2XEINIAZFrblWUEpCE57Xd+zG0I4pq/bBucRDTv1Qft8KSx7kdUc+1pLXV985d
	U8h0rzsdv+PiBanGhXiEBGIrMWb76puyX5jOmaG5QXgbf5/z5sarIAQLve+MANL65tAVDiAHUcH
	CTtulCF9XQ7Ppn0AAvmteQUwjgY0VsTUZjIxKx8wXGFeyioc4jYwwkkYD25rStCxojxn2QKLJrx
	slK3+0W4+CPF0KK/r7iKbsZNh1GTP7oYVldE7tDRmJi8t3m8ZXiKAa96iBZHLH0OWyK3XSwk44r
	/jQ3i6rIp0/fjDfr4frwYkqMIQ=
X-Received: by 2002:a05:693c:820f:b0:348:fc1d:cb22 with SMTP id 5a478bee46e88-348fc1dcd43mr4915177eec.21.1790644193904;
        Mon, 28 Sep 2026 18:09:53 -0700 (PDT)
Received: from Gris-Laptop ([116.169.5.123])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-347328dd123sm9591234eec.13.2026.09.28.18.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 18:09:52 -0700 (PDT)
From: Gris Ge <cnfourt@gmail.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Benson Leung <bleung@chromium.org>,
	Andrei Kuchynski <akuchynski@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Pooja Katiyar <pooja.katiyar@intel.com>,
	Hsin-Te Yuan <yuanhsinte@chromium.org>,
	Johan Hovold <johan@kernel.org>,
	Gris Ge <cnfourt@gmail.com>
Subject: [PATCH v2] usb: typec: ucsi: Skip CAM query when partner has no alt modes
Date: Tue, 29 Sep 2026 09:09:37 +0800
Message-ID: <20260929010937.21559-1-cnfourt@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260927021649.8967-1-cnfourt@gmail.com>
References: <20260927021649.8967-1-cnfourt@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since Thunderbolt alternate mode support was added,
`ucsi_altmode_update_active()` is called on every Connector Partner
Changed event.  This made the driver send `UCSI_GET_CURRENT_CAM` to
PPMs even when the partner had no alternate modes registered. Firmware
that does not support the optional alternate mode details answered Not
Supported, which produced a spurious error on every partner change:

```
ucsi_acpi USBC000:00: GET_CURRENT_CAM command failed
```

Fixed by skipping the command when there is nothing to update.

Fixes: da87d45b1951 ("usb: typec: ucsi: Add Thunderbolt alternate mode support")
Cc: stable@vger.kernel.org # v7.0+
Assisted-by: Codex:deepseek-v4.1-flash
Signed-off-by: Gris Ge <cnfourt@gmail.com>
---
v2:
  - skip the invoke of `ucsi_altmode_update_active()` in
    `ucsi_handle_connector_change()`
v1: https://lore.kernel.org/linux-usb/20260927021649.8967-1-cnfourt@gmail.com/

 drivers/usb/typec/ucsi/ucsi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index bef3f9b71d71..c392afdc27ae 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1519,7 +1519,8 @@ static void ucsi_handle_connector_change(struct work_struct *work)

 	if (con->partner && (change & UCSI_CONSTAT_PARTNER_CHANGE)) {
 		ucsi_partner_change(con);
-		ucsi_altmode_update_active(con);
+		if (con->partner_altmode[0])
+			ucsi_altmode_update_active(con);

 		/* Complete pending data role swap */
 		if (!completion_done(&con->complete))
--
2.55.0

