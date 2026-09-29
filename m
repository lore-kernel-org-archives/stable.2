Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F5B5187DF
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 11:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790682592; cv=none; b=KmdEaHiR7SOV/wIJz+zINZM/Aqz9LTIFTfPacrR0BT2eJIN92ysEgJNQSuM7wq28NYhAUFxZ3SAo0VC4TuoUFv+zsq2Z1FI/dxfeZGe6zcbDom3hPxbNLNSlviu6/AuAfJfkeEoaH2KDLPmLywUkZKDl23AUk067EdBM3VEJJxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790682592; c=relaxed/simple;
	bh=PY9uVZExFC3Baf/5umJcC9OHeawUCq0vNhempoDWWeM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iVHrb2SY9j3XUiE5j7kWZP4XUAfU3sAC7ucBbF5b/NJgEYs040HLP4qQLprvUTYbLGDNfjXoEP/E/YntTzorarYLEkiOXuRUToK8CcsweK8uolvhpUPpbCZ5HAod43tmkD3r9JiEcPkbnKMiW8/0sxDSSX+iiLFyWZk5r5o5jM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b5ETxVEp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b5ETxVEp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F3241F00893;
	Tue, 29 Sep 2026 11:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790682590;
	bh=JT94RmuSaTZBReTc+nU6RM2tobitZejW9dbWXEYvKk0=;
	h=Subject:To:Cc:From:Date;
	b=b5ETxVEpAOGSxfpqKy0QAKkFloqWSxIQ7TKmsL+zkiM2gIOLF2e1a37a39kPxnlKJ
	 BkY+RgHU5Tiif4W1iZv0NaUFqZpFeA84/XEJE9Rp7cpLcuhHBiTRdRLXN/pLlH+nZ5
	 M0noHx9YyewP2GOGpISY/J5axXk+/w/CHUKmNclc=
Subject: FAILED: patch "[PATCH] Bluetooth: ISO: release unused CIS holds after channel attach" failed to apply to 6.6-stable tree
To: qwe.aldo@gmail.com,luiz.von.dentz@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 13:49:37 +0200
Message-ID: <2026092937-animate-footing-cd66@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 0fcd4dad555c96e0bd3a1b8c569f989be85c7341
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092937-animate-footing-cd66@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0fcd4dad555c96e0bd3a1b8c569f989be85c7341 Mon Sep 17 00:00:00 2001
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Date: Tue, 15 Sep 2026 13:04:30 -0300
Subject: [PATCH] Bluetooth: ISO: release unused CIS holds after channel attach

hci_bind_cis() and hci_connect_cis() return one hci_conn hold for the
ISO layer.  A new channel association consumes that hold, which is
eventually released by iso_conn_free().

There are two cases where iso_chan_add() does not create an association:
it returns success when the socket is already attached to the same
iso_conn, and it returns -EBUSY when another socket is attached.  The
hold returned for the current call is unused in both cases.  This occurs
when deferred setup calls iso_connect_cis() again for its existing
socket, or when another socket attempts to reuse the CIS.

Detect the idempotent case while the connection is locked and release
the unused hold after iso_chan_add().  Also release it on -EBUSY.  Do not
drop it for other errors: a newly allocated iso_conn releases the
transferred hold when its last temporary reference is put.

Fixes: 69997d50ec57 ("Bluetooth: ISO: handle bound CIS cleanup via hci_conn")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index eb99653f33f9..7657c2a0abbf 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -496,6 +496,7 @@ static int iso_connect_cis(struct sock *sk)
 	struct hci_dev  *hdev;
 	bdaddr_t src, dst;
 	u8 src_type;
+	bool already_attached;
 	int err;
 
 	lock_sock(sk);
@@ -568,8 +569,14 @@ static int iso_connect_cis(struct sock *sk)
 		goto unlock;
 	}
 
+	iso_conn_lock(conn);
+	already_attached = iso_pi(sk)->conn == conn && conn->sk == sk;
+	iso_conn_unlock(conn);
+
 	err = iso_chan_add(conn, sk, NULL);
 	iso_conn_put(conn);
+	if (already_attached || err == -EBUSY)
+		hci_conn_drop(hcon);
 	if (err)
 		goto unlock;
 

