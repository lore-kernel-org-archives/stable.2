Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090CC423798
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 21:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783460227; cv=none; b=mW7OHO1C8+d49PLGNh7mL9vCt26z4Ainn7ric5+DJUbfQ/cNfcrbhnZ+BX6dTMREZ+gqP7bHhz17dVd98P4uMFvru3Wf3GSEVu6yzdddoWdC99MTxVASgm4IFyn/TxzYAGTLaZehwVsV/VZvXAWaLwUzZHn+kDOXWKd2gxyvsvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783460227; c=relaxed/simple;
	bh=JFsLmEKyfdTdtXMq6EUaN5UhDjHQN2cuAZLED+NvvyA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C+df3bMJjbSpI9aCe1DAHmzII0STW5H1cQxxZFEMbRCugWMepw2SGY0JMbJ9vBbdpag6JdE/m/XjSv3gsZC+QxjOitr5CNo2byjNExgoL+TljQbUJr+z5bcHEZWNWdzys03hsDde18n9U58bD1DmlW4G7nqju1QsjUldcNHJXzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=GjZLvBLn; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="GjZLvBLn"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47c6e9a694bso12048f8f.1
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 14:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1783460223; x=1784065023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fo0QDLa6YknvhmREei5gKWi0JYOHdfUxXGn44oX0+dY=;
        b=GjZLvBLnvqBF3VF403lFd3a41A/IQXFRCGBY7fEfl7YUjFuIfsR2Jf53Vg3IKD7XjD
         YKQz2MszKIaaxgsWACMTVMqfuY9C4a6Ic/4kRpljMpKDxhT+bHm3C/7xHy6e32OtvGZj
         TcVNn/IkvWNKNz2atz2asq2IhfC05cHoE2H39ghScCajzh6YDWB+ftx2u4+vTZhOsAwD
         PWOLs8MYS3qfjMYALAmIMeO7PbZFrtRIe9MzWLYcGtTCbzsI6WmFvJe2Mhy+R/o47j/y
         /CtaVM7EwC90jIi2Y/TPC2PdSst+dNgua2VW0V1M/pivEqu65/lfsckuMSyUV6CJlpp+
         ofqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783460223; x=1784065023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fo0QDLa6YknvhmREei5gKWi0JYOHdfUxXGn44oX0+dY=;
        b=IEw+6wtB0yXQxmMvHKNgziP0X//spsuqR0ymdQxNXtyrdH6koOfi+h/KOSOaiXNUa5
         7cqbc1aNzgZX5k0Yo7jPZTBKUdltUwXi1z3uRlFXjCOOa1lI85XOQR9+y/OEakh5ngFd
         V5Uqm7Lct9aaGYRerWfKBIFAIC+ojg9TOHagZ5tg9o05gaOz1HPgZlqjILyPmBfizL/6
         8VCEerNnosXVQOyniDYZSDA34gzKqRjW0uYdmp3LstASr71cW80dOeAHMn52Ya1qxyBq
         9wiu+5kcBNLcxOhODzU9uUWxYBlu51vYbq2Qf24Y1orDc3HVDBHh7j9aSxq8eieE2FG0
         a+XA==
X-Forwarded-Encrypted: i=1; AHgh+Rpr+OPfkhU9urX/s6SVS3YyYGVDLC6LG2UtxEx5qQ5QVPB4Xlm7/2KxHKOw0mrvAXEZzXW66RI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHxPXl0FrhObM3DW5fTza60u3L4vp6nIlz6XYlYd7JTTW0sWde
	a+7zXwwujMsb3J8dUq7DqbEs42jdu6D/QKcFof/mS8iIq/ILsoEOwv9HW9woQwsd9eg=
X-Gm-Gg: AfdE7cmywu2LHtX2qjXBzm5Kb4Lq5iZgE+biAcWd7EIRTDNnPzBkywU/8d/knwb0dcl
	Nguak4GPSQeYzJ5J7QHNPyW38YXq7QN/vz7VLHBTCsIIjLxjbTF0JQIihqkFzhQFEaDm3NVVXXn
	QHwDNNm1BIgo0dQVLV8+JxEDlsLpmKtDNYwC1nQpT0wHWA/KVw08XlvZaycFZ/WT/cBmWAPbDK7
	b0YJryB2uDaSaq6hzM+l5+V98rGcS/ksSTefoeahthfG3rK9HmDmIxQRo9iU78F9bHaN4opdFCi
	y+ZQJXlCYpGWEZx6sjRUkMWYA1gHsTxGIHcI5oMGDb3wdLFSXwNU8/4iXODoJGWQtWxhKw2Xdxm
	oTaYCdSHEUxL2WZFDI7dj7BrllXZUWwzOsWkLymjGMEEBpu6mhn3srexHc7M12wuKxUe4pM842a
	7JWE1a2znSIPoxyhp3g/+IrEvVKC6F9zlGB0uk2LcsvVdkmg2n3auHTTcU6vytXmklY8GP3Lh72
	enrBslFVdFM0lsE
X-Received: by 2002:adf:fa08:0:b0:475:94e1:29d2 with SMTP id ffacd0b85a97d-47de66503aemr5637948f8f.2.1783460223350;
        Tue, 07 Jul 2026 14:37:03 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f45eb00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f45:eb00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0960af0sm33829106f8f.30.2026.07.07.14.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 14:37:03 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH] ceph: force a cap message when a deferred revoke can't be acked immediately
Date: Tue,  7 Jul 2026 23:36:59 +0200
Message-ID: <20260707213659.8939-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the MDS revokes capabilities, handle_cap_grant() normally
guarantees a response by setting `CHECK_CAPS_FLUSH_FORCE` (see
commit 31634d7597d8 ("ceph: force sending a cap update msg back to MDS
for revoke op")), so ceph_check_caps() sends a cap message even if the
client would otherwise decide it has nothing to do.  That guarantee is
skipped whenever the revoke has to be deferred (via revoke_wait):
revoking Fb while dirty data is still buffered (writeback is queued
first) or revoking Fc while pages are cached (async invalidation is
queued first).

In those cases, the ack is left to the deferred completion
(ceph_put_wrbuffer_cap_refs() after writeback, or the invalidate
worker after invalidation); both of which call ceph_check_caps(ci,0)
i.e.  without `CHECK_CAPS_FLUSH_FORCE`.  Nothing gets sent under one
of the following conditions:

- the inode is retaining caps because the file was used recently
  (file_wanted != 0; retain |= CEPH_CAP_ANY)

- the revoked cap is still used because the page was re-cached (e.g. a
  file being re-read)

- the MDS has meanwhile re-granted, so `issued==implemented` and the
  client sees nothing being revoked

The client then never emits the cap message which the MDS is waiting
for.  The MDS blocks on the revoke indefinitely and logs, for minutes
or hours:

  client.NNN isn't responding to mclientcaps(revoke), ino 0x... pending
  pAsxLsXsxFsxcrwb issued pAsxLsXsxFsxcrwb, sent 964.899182 seconds ago

The client-side state at that point shows the full cap set still
issued, nothing in the revoking/flushing sets.  Thus nothing gets
sent.

This patch fixes it by remembering that a forced response is expected.
When a revoke is deferred, set `CEPH_I_FLUSH_FORCE` on the inode.
ceph_check_caps() replays it as `CHECK_CAPS_FLUSH_FORCE`, so whichever
path re-checks the inode next (the writeback/invalidate completion,
the delayed worker, or any other caller) is guaranteed to send a cap
message to the MDS.  __prep_cap() clears the flag once a message is
actually built.

This is the deferred-path counterpart of the existing
`CHECK_CAPS_FLUSH_FORCE` handling; a normal (non-deferred) revoke
still forces the response inline as before.

Cc: stable@vger.kernel.org
Fixes: 31634d7597d8 ("ceph: force sending a cap update msg back to MDS for revoke op")
Fixes: 257e6172ab36 ("ceph: don't let check_caps skip sending responses for revoke msgs")
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/caps.c  | 40 +++++++++++++++++++++++++++++++++-------
 fs/ceph/super.h |  5 +++++
 2 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 4b37d9ffdf7f..132936eb6b91 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1410,6 +1410,7 @@ static void __prep_cap(struct cap_msg_args *arg, struct ceph_cap *cap,
 	BUG_ON((retain & CEPH_CAP_PIN) == 0);
 
 	clear_bit(CEPH_I_FLUSH_BIT, &ci->i_ceph_flags);
+	clear_bit(CEPH_I_FLUSH_FORCE, &ci->i_ceph_flags);
 
 	cap->issued &= retain;  /* drop bits we don't want */
 	/*
@@ -2038,6 +2039,14 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags)
 
 	if (ci->i_ceph_flags & CEPH_I_FLUSH)
 		flags |= CHECK_CAPS_FLUSH;
+	/*
+	 * A revoke whose response was deferred (see handle_cap_grant()) must
+	 * still be acknowledged.  Replay the forced flush here so that even a
+	 * check triggered by writeback/invalidation completion sends a cap
+	 * message to the MDS.
+	 */
+	if (ci->i_ceph_flags & CEPH_I_FLUSH_FORCE)
+		flags |= CHECK_CAPS_FLUSH_FORCE;
 retry:
 	/* Caps wanted by virtue of active open files. */
 	file_wanted = __ceph_caps_file_wanted(ci);
@@ -3744,13 +3753,30 @@ static void handle_cap_grant(struct inode *inode,
 	BUG_ON(cap->issued & ~cap->implemented);
 
 	/* don't let check_caps skip sending a response to MDS for revoke msgs */
-	if (!revoke_wait && le32_to_cpu(grant->op) == CEPH_CAP_OP_REVOKE) {
-		cap->mds_wanted = 0;
-		flags |= CHECK_CAPS_FLUSH_FORCE;
-		if (cap == ci->i_auth_cap)
-			check_caps = 1; /* check auth cap only */
-		else
-			check_caps = 2; /* check all caps */
+	if (le32_to_cpu(grant->op) == CEPH_CAP_OP_REVOKE) {
+		if (revoke_wait) {
+			/*
+			 * We can't ack the revoke yet: the response is deferred
+			 * until the writeback or cache invalidation queued above
+			 * completes.  Set the CEPH_I_FLUSH_FORCE flag to remember
+			 * that a forced cap message is owed so that deferred
+			 * completion (ceph_put_wrbuffer_cap_refs() or the
+			 * invalidate worker, both of which call ceph_check_caps())
+			 * actually sends one, even if by then the revoked caps look
+			 * unused, the inode is retaining caps, or the MDS has
+			 * re-granted them.  Without this, the cap message is never
+			 * sent and the MDS hangs ("isn't responding to
+			 * mclientcaps(revoke)").
+			 */
+			ci->i_ceph_flags |= CEPH_I_FLUSH_FORCE;
+		} else {
+			cap->mds_wanted = 0;
+			flags |= CHECK_CAPS_FLUSH_FORCE;
+			if (cap == ci->i_auth_cap)
+				check_caps = 1; /* check auth cap only */
+			else
+				check_caps = 2; /* check all caps */
+		}
 	}
 
 	if (extra_info->inline_version > 0 &&
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 1d6aab060780..878440a2eb3b 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -687,6 +687,10 @@ static inline struct inode *ceph_find_inode(struct super_block *sb,
 #define CEPH_I_ASYNC_CREATE_BIT		(12) /* async create in flight for this */
 #define CEPH_I_SHUTDOWN_BIT		(13) /* inode is no longer usable */
 #define CEPH_I_ASYNC_CHECK_CAPS_BIT	(14) /* check caps after async creating finishes */
+#define CEPH_I_FLUSH_FORCE_BIT		(15) /* a revoke's response was deferred;
+					      * force a cap message to the MDS once
+					      * the deferred work completes
+					      */
 
 #define CEPH_I_DIR_ORDERED		(1 << CEPH_I_DIR_ORDERED_BIT)
 #define CEPH_I_FLUSH			(1 << CEPH_I_FLUSH_BIT)
@@ -699,6 +703,7 @@ static inline struct inode *ceph_find_inode(struct super_block *sb,
 #define CEPH_I_ODIRECT			(1 << CEPH_I_ODIRECT_BIT)
 #define CEPH_I_ASYNC_CREATE		(1 << CEPH_I_ASYNC_CREATE_BIT)
 #define CEPH_I_SHUTDOWN			(1 << CEPH_I_SHUTDOWN_BIT)
+#define CEPH_I_FLUSH_FORCE		(1 << CEPH_I_FLUSH_FORCE_BIT)
 
 /*
  * Masks of ceph inode work.
-- 
2.47.3

