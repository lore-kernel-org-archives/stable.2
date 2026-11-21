Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795279145;
	b=x/c0VZAHElCCiXMz+8SuAvcSONESoHwgGe0Q/hEA7OEdDqezed3SBfqx8tqNjeJSs02i
	 MPz/A9uOk00FGGFNYGq4R8v2PFimFUCiFZ7enatWh3hfjlQgXTlAF0pbanPiCOlmlc2EO
	 Zt5LQYz4bb26AugDN9MtoF2JxAiJODpeqm3K0PqqbevS+dRlVZql3xdMD1S3b8Vq5KO4b
	 FYhDbWoJbQxKkuRY7yvVYonvpq/Hvd7VwVdvWJkp+FGs+RxfOTLIYrH07VNwHKUBma6Mu
	 eK3eKNeyKtdZ5VyYkMa+po25e9itMb9b9VDWM3TII0YZQp8sAdE1XpxhVcsECtqcbVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795279145;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Subject:From:To:Cc:
	 Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=UvpOy7GOb9rkObKegTI8SaLmn0rbNgwEAUXCgiEk9Sg=;
	b=3/R+WmWyvfEa/uRVBzsEtDGaWtj+3iDt+Cnri0idjeQrxtTNWvGszoyf+RCNrA63LQyy
	 Gh98wq4jnZtNhE5bJD5RjlH234k26DPnmOIB6MQG4Jb0G+vX/w0+n2fiWzInwZCSwEQjT
	 WClk1bdGwe1h/u/MXN1qvycgqoo6eUWae+Ol7Jv0/T71Im3PpTpquRYziLna3xpl7htDJ
	 vrChGMqnAqGa8zmt3iBJ0AOxjxv2SnQftGqY4spTv4AtfWX6hbfUGGBgz1YFQv7QC+g9Y
	 HaqnJVWDYgYsWUGLk9Lxg6yJaLRr8BjOnpvmHY5i4uJIR+CBcQJk/rv+RlusJsX8Icw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f+MzvHFf;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00573606A32C
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 16:39:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00573606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f+MzvHFf
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48e20ed3b9dso1688729f8f.2
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 08:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795279143; x=1795883943; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :cc:to:from:subject:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UvpOy7GOb9rkObKegTI8SaLmn0rbNgwEAUXCgiEk9Sg=;
        b=f+MzvHFfqQ9WcbUSNKxJj1Ic+3RE+07hDar/TjwNI5eDF9Qio/PkinckXvA/B9AC4q
         SQZJsP69aC01AzYvoojV9pj8fpG7bmLXfjM83jVrB2QwD/3JahcKWGlzGFztuyk0SE4l
         C9Wbx73I5pQxtxIQRauurGKZZZyWH5csSjD/6BUu7b12cLSa3ufRkyAOlSZ1VFUUp8yh
         kOCQ65OkPWm/SEe+z7C3wxy37KuDBaElNZeOtipOTXYGi8uAczrYwqeotlRWPxz+64i1
         Y4I2dkkPzLS8XuAQt+7hkD3x8jdYamrzMoUaPT6rjiwk4aNIvDAIqodTht+Mnk96mZA4
         IbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795279143; x=1795883943;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :cc:to:from:subject:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UvpOy7GOb9rkObKegTI8SaLmn0rbNgwEAUXCgiEk9Sg=;
        b=g6YhWU1DjUaD1YM0KrylNGllKAS/R1+HElzUktJsU4isKABL+cw9LhhZ/GiVyWbWS2
         Jfblr8Tj3Ju1R7DffBSybeX/ftyA7l8TC5B1mJhVPQ92lBQ8npe+E2QKqGpUUO9rdq8j
         C7/1ODFcsALqF1N4S8Ofryi+Nxicz0Q2XkTm4x65OSE3gV3HRa6syM/swGZlamvbkfW+
         DGcqt5sUCTKeocWylU1hv8LjKP/SQBaj9bd+4QaiYC8D7xsnJlcD8KKOD59aGIRZhEr/
         ug+z9FKaDFRCaIR/QDwySN/WSbh90/vZ2MSQMRuXMBRrX55Fc9OhPe7HoodZ0Yvdxese
         +lKA==
X-Gm-Message-State: APuU4Z9wAzPhJZrvZKyGYa7oNfaPsFjWii3DD2zlXcMlq3Hmg2bUlglj
	rDkFdzPDkyhc/on/bW+s/ZEc79hRvuZhkaocOTOE/wwJ+FnzCyEDK87CSKhefALCbYfz94Dl
X-Gm-Gg: AZFdTZc4L6tUOTbUzX/bp1nKB5SVDRe/Bkv7NQBfvNt8rUizmL03PnsyDooCqcSM/kX
	JfI/8v6VwJ6XpLkDxs8epfaNxsM0CXZksxOHjCa8KCYNn1Aa0THcTZcx/EDs9UqBCF2KvF+qfcl
	Fmd9gkHU1/Z3CtveivHN/sYf+g5vkdYgRafoJ1LyhZbf5+LWkt1NvJo8zGEKYkkryZ7EZMhVsEf
	Q1Gsyd70k8HEWwBNF2/LP42m5rG7zJfylfMDtVY2awux5Ug2IFzKY2bzLr9TCewGTCp+82a+eXR
	VPJ6dlJxwXw2v0OCCYWMBA91aPf6aqh02OxQLvPE4JtLUVB7Fjr53HSnvySkAQ7GhS6ofLGRZ1H
	3KGvutda8l9ndZnlYEHcxHXoboZN9W8DZPqAsbLT2w35W4KmrVE92DxR3WmH7LtJYhkjTxE+Gim
	O1T1oYzOVgQs0tooci1ymaHdPrBiMgfEX70bf2zPbTSabOhLE5irpqU2nFWmWrUgh/hDHYQ6Xkn
	fHhkVmc4EZf4AUPseQNZogHSuc3hoFVtLP/z4voIxcG1RkfbrXE9YF0W+FUS9f7FB+pTq64y7G6
	CTyrZvr00p8/UvP7vgXdbhmcNi/1H8LbPGgutj9Sm5Ny
X-Received: by 2002:a05:600c:5246:b0:4bb:60ba:49e0 with SMTP id 5b1f17b1804b1-4bb88930707mr157734315e9.26.1795279143087;
        Sat, 21 Nov 2026 08:39:03 -0800 (PST)
Received: from [10.77.1.44] ([94.188.8.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf61b8sm11212895f8f.19.2026.11.21.08.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 08:39:02 -0800 (PST)
Subject: [PATCH 0/1] scsi: target: iscsi: fix use-after-free in iscsit_stop_session()
From: Vitalii Dodonov <dreamer.two@gmail.com>
To: linux-scsi@vger.kernel.org
Cc: stable@vger.kernel.org,target-devel@vger.kernel.org
Date: Sat, 21 Nov 2026 19:38:57 +0300
Message-ID: <179527913740.32224.2426414360492240680@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

The iSCSI target panics with a general protection fault inside
iscsit_stop_session() when a session that has more than one connection is
torn down while another thread closes one of those connections.

iscsit_stop_session() walks sess->sess_conn_list with
list_for_each_entry_safe() and drops sess->conn_lock inside the loop.  A
connection that is being shut down concurrently runs iscsit_close_connection(),
which removes itself from the list with list_del() under the same lock and
leaves LIST_POISON1 in conn->conn_list.next.  Pinning the next connection with
iscsit_inc_conn_usage_count() keeps the object alive, but not the list links,
so the following iteration computes conn_tmp = list_next_entry() from the
poisoned pointer and passes it to iscsit_inc_conn_usage_count(), which takes a
spinlock at *(conn_tmp + offsetof(conn_usage_lock)) and faults on
0xdead000000000004.

Crash, 7.3.0-11-generic, LIO target with MaxConnections=8, Microsoft iSCSI
initiator holding 8 MC/S connections, graceful reboot of the initiator while
I/O is in flight:

  Oops: general protection fault, probably for non-canonical address 0xdead000000000004: 0000 [#1] SMP PTI
  CPU: 0 UID: 0 PID: 9028 Comm: kworker/0:2 Not tainted 7.3.0-11-generic #12-Ubuntu PREEMPT(lazy)
  Workqueue: events iscsi_target_do_login_rx [iscsi_target_mod]
  RIP: 0010:_raw_spin_lock_bh+0x18/0x50
  RDI: dead000000000004   RBX: deacfffffffffcb0   R15: deacfffffffffcb0
  Call Trace:
   ? iscsit_inc_conn_usage_count+0x1b/0x40 [iscsi_target_mod]
   iscsit_stop_session+0x7d/0x1b0 [iscsi_target_mod]
   iscsi_check_for_session_reinstatement+0x1e1/0x290 [iscsi_target_mod]
   iscsi_target_handle_csg_one+0x135/0x160 [iscsi_target_mod]
   iscsi_target_do_login+0x32/0xe0 [iscsi_target_mod]
   iscsi_target_do_login_rx+0x2d2/0x420 [iscsi_target_mod]
   process_one_work+0x1dc/0x3f0
   ...
  Kernel panic - not syncing: Fatal exception in interrupt

The same fault is reachable from the logout path:
iscsit_stop_session <- iscsit_logout_post_handler <- iscsit_response_queue <-
iscsi_target_tx_thread, with the identical 0xdead000000000004.

Where it was first seen (field report).  A Proxmox VE host (7.0.14-9-pve,
later 7.0.14-28-pve) exported zvols through LIO to Windows 11 clients using
the Microsoft iSCSI initiator with MC/S.  The host had been stable for 95 days
with MaxConnections=1; after raising it to 2 there were four panics in one
night, all with the same general protection fault at 0xdead000000000004 and
the logout stack above, and the journal of one of them contains "Received
logout request on connection that is not in logged in state".  The panic also
reproduced on 7.0.14-28-pve, so it is not tied to a single build.  The module
carrying this fix has been running on that host for 9 days with
MaxConnections=4 and 72 active iSCSI connections, without a single panic.

Reproducer (any MC/S-capable initiator; open-iscsi does not implement MC/S, so
a Microsoft iSCSI initiator was used):

 1. LIO target with MaxConnections=8, no CHAP, generate_node_acls=1.  The
    value lives in configfs and is not exported by targetcli:

      echo 8 > /sys/kernel/config/target/iscsi/<iqn>/tpgt_1/param/MaxConnections

    With MaxConnections=1 the extra connection is refused with
    ISDSC_TOO_MANY_CONNECTIONS and nothing happens, so the target has to be
    configured first.

 2. Initiator: log in, for example on Windows

      Connect-IscsiTarget -NodeAddress <iqn> -TargetPortalAddress <ip>

    and then add the remaining connections to the *same* session, one call
    per connection:

      iscsicli SessionList                 # take the "Session Id"
      iscsicli ListInitiators              # -> ROOT\ISCSIPRT\0000_0
      iscsicli QAddConnection <SessionId> ROOT\ISCSIPRT\0000_0 <portal-ip>

    Repeat until the session holds MaxConnections connections.
    AddIScsiConnectionW() does the same thing programmatically, and the
    "MCS..." button in the iSCSI Initiator GUI (target -> Properties ->
    Sessions) as well.

 3. Bring the LUN online, mount a filesystem on it and start writing to it.

 4. Reboot the initiator gracefully while the I/O is still in flight; repeat.
    The stock module crashed on the 2nd-4th cycle (2 panics in ~20 minutes).

Results: stock module 2 crashes in 8 cycles, patched module 0 in 118 cycles
(the target stayed up for the whole run).

Patch 1/1 takes a snapshot of the connections, with a reference on each, while
conn_lock is held, and then works only on that snapshot; the order in which the
connections are reinstated is unchanged.

Vitalii Dodonov (1):
  scsi: target: iscsi: fix use-after-free in iscsit_stop_session()

 drivers/target/iscsi/iscsi_target.c | 68 ++++++++++++++++++++---------
 1 file changed, 47 insertions(+), 21 deletions(-)
