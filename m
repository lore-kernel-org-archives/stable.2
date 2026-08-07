Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4CA37757C
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 07:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786086566; cv=none; b=QmLrlRaUbL2d0+UuMdQh+KEonAhn4ADsN3z+txvsVabFUeIhlj/WLE4/6UdwJzTDXbFGXG6oCz8Qnj8ofnzlFOiuJ7faJRJ6pbZnBV7Gualujj8Rzeip7FaHfOn5Zly6MWBZCvD1vTZzx3zrQKEvkF6V2O1AOFy//+CA25LgOtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786086566; c=relaxed/simple;
	bh=cs+sCnn7xWiEgcV9ZSxKwtCGXZUQ9wbMPoLQAd9HEts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eE9xpex51k6Hiofao84NOk4lu4FGEQIkwR956gnBFXgiiZLEbtDHBdLd56AO7EfkChOiyn90eloyg5uhz7TfOMSfl5WHGF1xtcYGF/BcdUWrI6NmHP3iCAKRVhzgt0atGijwOFqx4fC4r1axmo/hluOG+B1JUsl6AMmSo4Y1K/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com; spf=pass smtp.mailfrom=xbow.com; dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b=ZVE73slM; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xbow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b="ZVE73slM"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-81f3b227a4aso49767317b3.1
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 00:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xbow.com; s=google; t=1786086564; x=1786691364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G7gB99jopYOI8TNqTIZ3KOn+F7j/uZRYCXYb3SJDHNc=;
        b=ZVE73slM2iSPT9P/Bo1pcg7ZLuJREBXejbMiTHysbfpeeKrSNimG3C7FC9aapU3bA1
         BKmEEJF+5HNIIXPMbw12NExY9BM20PWd+Ef2xTc7ChBk8regOpOUt2mCMZEShNsz79VX
         pR3no+L1bFmvuxf3I3DOFje5QfScQWGA6UC0JFwwLJJMqPL9EOfBJQwyugdE5W+yankV
         /8Uh1/Ko6axwshAL1SzIIt5icIjc2+RC1YSCjfstFcSJIJoSpxyU+RE4Tpd0WXq3h/2h
         Pe8aAqZ5nEBUmUQCJIL2UUeiUt+QovYfjmmrddHWFC3BWY0xfLw+hSn6jgKTyTt/n0D3
         VMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786086564; x=1786691364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G7gB99jopYOI8TNqTIZ3KOn+F7j/uZRYCXYb3SJDHNc=;
        b=rlDlRckfXh4MjMg33bXHuKJ2H79soYK7WjG3wsLn3nVXrA5YckVNSjcrJUUgm+7+72
         neLjKvjmiqtEqUn7lQu3xwngTJDso58aKGQyrwXOeONQPlI29yCwbpxldGWQa0eZDthc
         S/AKeLkZSPPGmaQ+24UrsqFT1p3SepeG0GSDldd2uLjs+hfCS4q8Y1SyyVZcJgDLAqud
         SrUXCP9L1xTrRII6fm7sVooEun7ZP+kze+BbUvasLC1r39ZQ/i8SdhQZaN0KglXZ1OY1
         RAcmjQ3d1oVx/s+66P7ZjYzhLcgke95V7zSJcGKo3NTF1jVr8Kd9esHTa57nVm0Bx6eh
         H0Xg==
X-Forwarded-Encrypted: i=1; AHgh+RredOCrcPu14nYdNpQw7zGxQ3exDAB3omkuyFYXm9274Bx/KyhQjrT0Z8flauJboUp0kVybpI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbbO5qcfgzl68rO6xIYx2+yAXMPYt1znEbK67tRUCjTmujf+aU
	Ei1f7PkRN3M1wVkBy7g9o5z4VUBGCuqt8+pWAbRQslgdUbg1fELF2Bd9qhJNY5lxais=
X-Gm-Gg: AR+sD13uTw83fTMQqQHj5tUVVM+j5tHUUzxT5/lkdnzzSDFUZJ7LsIOGseQoZYyzUQC
	D1vS5aVI1z4CHiLolbESNZWQdjyUUOEWLg1b0SOWfloY/vKxWUreLaXI6EiVGZ4+52ycBG3mzS4
	5xegQhhAG+d2+O+yahiHkBKJFDJsEeOHWi3pMrHxPBkMFXBGX9EYoBZ53QDXiyqRysrXaauYwKZ
	Qhq7+KrJmoOi7Mkg3BOyRQi59YWNzTm62/r3OapMxJm2A0gt900FC69A6xQd1Y5xkHJ8l1Jxt0D
	CdIB96V59oHDDDJ35TIKwu0EQIIamsSSOPvGUFtsmozehCpfZD5sIcJLDQZi7z4DBE9qvTrJAeD
	97RsvpQNDY5uqfcswh3Z9+/cQok5rf60Kd0MzWdUoRADr5d9WjgoKlbCVEqz9LqfLEupHlZqnSq
	Nypk3VpA4cPcvxR9yvD3qB7wxphHHf7oQl6AgWdmeIUM+lbQfIQ2/rIYnofMV+xWDSPWy1rIQdG
	cwDnRGZYKCB2GBrPxR4KXwo2TbYyb8DHRK0aLChvxJO/QYFX2WPNtP9ZdgF6SuXesiWjxGcmQE7
	52NEt/882+XsNts9hTfY7BHkxpHQGPci6cc=
X-Received: by 2002:a05:690c:6602:b0:80b:a1c7:9f95 with SMTP id 00721157ae682-8201bccf906mr129185607b3.5.1786086563843;
        Fri, 07 Aug 2026 00:09:23 -0700 (PDT)
Received: from buildmachine.tailf331da.ts.net (ec2-3-14-143-233.us-east-2.compute.amazonaws.com. [3.14.143.233])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-823f0e64324sm5230367b3.19.2026.08.07.00.09.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 07 Aug 2026 00:09:23 -0700 (PDT)
From: Baul Lee <baul.lee@xbow.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Brian Gix <brian.gix@intel.com>
Cc: Baul Lee <baul.lee@xbow.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	federico.kirschbaum@xbow.com
Subject: [PATCH 0/3] Bluetooth: MGMT: fix use-after-free of struct mgmt_mesh_tx
Date: Fri,  7 Aug 2026 16:09:13 +0900
Message-ID: <20260807070916.85771-1-baul.lee@xbow.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hdev->mesh_pending is extended and walked from syscall context under
hdev->lock, and unlinked and freed from the hci_cmd_sync worker under
hci_req_sync_lock, so the list has no protection; the objects on it are
also handed to hci_cmd_sync_queue() as raw pointers, and those work
entries outlive the list.  Three use-after-frees follow, all reproduced
under KASAN.

Patch 1 removes mgmt_cleanup(), the one walker of the list that cannot
take hdev->lock.  Patch 2 puts the list under hdev->lock on the worker
side and asserts it in the helpers.  Patch 3 gives the object a
reference count for the work entry.  The order matters: the assertions
in patch 2 have no violating caller left once patch 1 is in, and the
reference in patch 3 is only well defined once every unlink happens
under one lock.

Reaching any of this needs CAP_NET_ADMIN in the init user namespace.
hci_sock.c sets HCI_SOCK_TRUSTED at bind under capable() rather than
ns_capable() and gates every later mgmt command on it, and the mesh
commands additionally need HCI_MESH_EXPERIMENTAL.  Nothing in
hci_event.c touches hdev->mesh_pending.

Each reproducer was run at identical parameters on the unpatched and the
patched kernel, built with KASAN, PROVE_LOCKING, DEBUG_LIST and
DEBUG_ATOMIC_SLEEP: every splat the unpatched kernel produces is gone.

Baul Lee (3):
  Bluetooth: MGMT: remove the mesh walk from the socket destructor
  Bluetooth: MGMT: protect hdev->mesh_pending with hdev->lock
  Bluetooth: MGMT: reference-count struct mgmt_mesh_tx

 include/net/bluetooth/bluetooth.h |  1 -
 net/bluetooth/hci_sock.c          |  1 -
 net/bluetooth/mgmt.c              | 72 ++++++++++++++++++++++++---------------
 net/bluetooth/mgmt_util.c         | 31 +++++++++++++++--
 net/bluetooth/mgmt_util.h         |  3 ++
 5 files changed, 76 insertions(+), 32 deletions(-)

-- 
2.50.1 (Apple Git-155)
