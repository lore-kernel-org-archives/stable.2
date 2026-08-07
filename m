Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66146470EA2
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 10:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786097739; cv=none; b=oxk3Y0iKHsTtQqO1MXYkhGp6VAk/6Jo089jY/WZa0ms2k3n6KRE3cThR/LAuNf+6kFLrviinrTxI5wSbX0/l37p+e+sBVivIUfWJaowLzf8UDLy+ipFHScw4LDWxJHIAkco8DjhyfmvB1284VTggXYH42SSuNvcqCYXK2MGjfIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786097739; c=relaxed/simple;
	bh=XU7SBVwoZ2gmzDIRGG1/wevQLi+4spBoLxZ+LV157CY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EQK3nDe8aWcHwRnLuGPXlzWu10g3caMfVNpQz4SfklDgV95htnk4RWXOUbIEtyrlU33cdiBWAk/JIwyMb5PEWdys5jZfjLIV5V8zYhPTeAHj0qQcJTFDQExapzgY+nPH+P+JMGSwYcbP7j1HD0N1139sORD3anTtLhzvH8Wm+eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com; spf=pass smtp.mailfrom=xbow.com; dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b=dDbHjJDX; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xbow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b="dDbHjJDX"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-39266382df6so307609a91.3
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 03:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xbow.com; s=google; t=1786097737; x=1786702537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dU0nW0nnnYVIBF5ljLRaJDGaH50na6JSFZ8vlLoM0Gw=;
        b=dDbHjJDXqEz2hczII+VxIrkJo/UkmJEwTu8FA+eOUDulphbYqpY0HErydJWaWcpnqk
         g/UmTvfPwJx3yL+gEIHOtUtxb78xmVLAFMD8LjuYK5iMNiqYgnzMLzACScmDil1Fq/f6
         P62I67HXSwTf3MRLuSCmuhnm5+ehX241vLeMgdAwdtQwHih/Y0oigzgjtcMiP28SJpOg
         p/b/VGoX5l1Jv0hOZ4vsbCG8tzIBiAnfdDtle0IWNu5D/gtTgcbW0wDqh3TKoJJ3eEmQ
         EbwZMM7y3k2iZgJVbODb8mxTwnaklSzBUSG98O0iUl4pPfoWbg4d8GTiY57yN5aUujox
         P2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786097737; x=1786702537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dU0nW0nnnYVIBF5ljLRaJDGaH50na6JSFZ8vlLoM0Gw=;
        b=qPrpuM9+Qp687rmKkdE6QpfBwgD0EipgfZgMTDleUgZdXovpV/gYCRzCRIpYH3iBMR
         1DbROdcB79BwDsunNlUTZgweUwISnORFfipPrUqYoqAFGBGinR3Fe9Xki24+V4yjRQxB
         GB2L+YV0ap00H2DrqCAj4d2RjJ7R+X5vp4iTrXLcDZyLlQgvb9n7poLAoaHYzn1Iz2dW
         /6PXk0o9cSKYS71FJBOlBc0Qgqu4nK4JYri9ZtE+tbGMzY7hUBPa/imgOrGuNf8IyND0
         3CzFxHXsp4Ab0T7udStXVtiKV8EWvHI8z40Pq6zH683mxxXIsdMDb4/51bMlz2uEsCDb
         i6RQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrq0lkdAd1CD3pl7s0cj6peGiFC/hhlmIyyxyQHZ1Z7JTyjs/c5u+Th7TBlnA4fCflUv2rHnJM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5A5j872/uX9tnxIKURaSxti2oXYqFFf5FIpea4Lp/SICSJS4J
	Y1uvBGkmgOvdf2RHrsWPONjYksebQD4dDgEAHKllOyYSSI7/jMbWOq5CAzZ/c4ueI8I=
X-Gm-Gg: AR+sD12Iibdu2opl/PhbUA5SXpBaajJcmj9Xl3JPKuH1/snWwM8kuwo3fAGyKf26CY6
	hrHjn8W6YjOjiuPWUe/FvPtPJ+z0Ja4X8j5udHdcH1sSX1r4e0NcrbiAm71QYM5mnbyMsbs6W8n
	1F/Q6ikHEfuzOGJjfqpClDWPFQMoI6uTrRQwOD107XsIFrCDZyjBUy1/KmQXsnpXlUOUHS1oxcb
	mE0Pr+novxAIwmEUecYCwLAavktklACTgVeMpHcbgU3hML+hGSsEj84Y53oT3RlWg/zzqnMuj4p
	aPrvcG33/deVWUErRtmNOCVGflhEuKJxJhnSdpBOQfa4W25SiR+s4EaeiJ/68B/Pj2o/2GvFBqW
	UNvjSEUtT813Zvu266Uf8aVmD43xL58sSevXvXXA2n45qN5i6vQeMTW8N4NRhMtE8btttZz/qL4
	DYZ0IDjXdjIi8aK7ohVWTCDE/Y95w+ts3aa4mIc9OWyOFKjv9ROtlpHw7dk5JVwS0ARRXKehoAf
	uSCPzuVzd+REDEjD0NkE2ZqaVXgHboYr1CpA2dOhSEpq8j3GavC+Rs=
X-Received: by 2002:a17:90b:264c:b0:36d:9e0b:3801 with SMTP id 98e67ed59e1d1-3903c59936cmr23131603a91.8.1786097736542;
        Fri, 07 Aug 2026 03:15:36 -0700 (PDT)
Received: from localhost.localdomain ([1.220.41.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085dea04bsm4399162a91.8.2026.08.07.03.15.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 07 Aug 2026 03:15:36 -0700 (PDT)
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
Subject: [PATCH v2 0/3] Bluetooth: MGMT: fix use-after-free of struct mgmt_mesh_tx
Date: Fri,  7 Aug 2026 19:15:26 +0900
Message-ID: <20260807101529.17348-1-baul.lee@xbow.com>
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

v2: rebased onto bluetooth-next, where send_cancel() no longer ends in
    mgmt_pending_free(), so v1 did not apply for the CI.  Context only,
    no other change; v1 applies as posted to the bluetooth tree, which
    still has that line.

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
