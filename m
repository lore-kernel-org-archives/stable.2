Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA629280CD5
	for <stable@vger.kernel.org>; Sun, 21 Jun 2026 16:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782059002; cv=none; b=F0DVtsaWh4XsBNydBrxcHxQTttr9XQHqGJQ0ZGCWc62vjdgrrFpylx+uoM49VsEJ66Ca+sZL+iwPVrIHMAnXHHEmCkyrCeA++NOYJup2q5CcpqnMcQZ0s6yNjTxmar9/DxZ6l4quveDRPdXuvt2w2hBCwRriPn2vpgNYamSKlS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782059002; c=relaxed/simple;
	bh=9D3krCGzGGlRpYwm56oiCtazTMOUWfsdff/eOQAoLCc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qKeGD2gRuTLH3LcMvYvQ8ZCVNtGY8YE/dyyMC/hQITx093dG0sFvtdGaIGJL1LZdAaTyr98mkEBp8rk9tJ7p4Nv6LZbEowgIwzWJMrjveoo3hkJvrPCL8BgC/sE56Fy+Ya73/oDElFxnxWCIntVgHhcT/Irqx17q6sgx5turMa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FxpgSqxr; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxpgSqxr"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c07d76ffd0fso331665866b.0
        for <stable@vger.kernel.org>; Sun, 21 Jun 2026 09:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782058999; x=1782663799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bybjcRHpNKQC6YvGZ5klSk+Kw3IBZ+UA74h0Z6azPxw=;
        b=FxpgSqxrnao4Vm8hwmKmqnK2juuVgYq2RXc97q9qUqRJPYC9JZbXDSaIVENzznvWIS
         KPbm3j+tZoTTmXRNPGeQ1eb24v0nki5bL6Rb7Ej0T1DDLB//PWyZPtwDtU9SIw8EBdk6
         E+cioNtbyiDUAomJvc7saJkW7rhuX9SnJrFV5RCjeqowN5sW+2a/eP/S7jFxCJAsrxSs
         lxVZdcSRJbLH4oG5b+2SNDBx5TaxNvTD6ZcTfuQwATCIb1qALJJbQznwop+PuzWk5YBW
         QKtVVvV1H5mG1lP4cjhBMH89x0UrCwGLvb0fl9xRd3hLE6lNfDB2VT6/wnxBtWqTTDp8
         Zhuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782058999; x=1782663799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bybjcRHpNKQC6YvGZ5klSk+Kw3IBZ+UA74h0Z6azPxw=;
        b=JGtBoL/Ila2rUzCQU0ugYsNd+7blQr4bveAEpDRjOd9GW7RVHoTZ0QCdI2ZahkjOxM
         OFHpEWBmEkk3xOd65kKoEh5s4yhPY55jYl+7oivoHWkTBf3/nL/vM7gnReTeDMZ3KINf
         sOAzSXoSSvdHR2vh1VobczlmXrVcWmD7f0/yNZeKXlYcHn4keyo2OVZZJ7qzQvK95BgV
         CHlcM0TiG7nf2Q9C5dLMkNHNIbyJrWhUPBBapiKyK2HjGLv/QwGYzx/OsUWPqZkgRJ1b
         ug4XrxDP7HnxqRLc9WRQctGkIaABn5cbkZqQThbIYsV2U+buYWoLLkcZkCe/Zrwrdijk
         +bFA==
X-Forwarded-Encrypted: i=1; AFNElJ+BUceJyHQjA1BwcK2eFM3rFtBxafXWc86Rd+39OwOlKWKu7Nl35FUQxxUbCGrvNjVoLAgzRAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqIz8zxQhuPOYpLjJHCRkCEBrJeJMg9W/OpnzMuRrCb65VKZv/
	yfbzEPJHfNu01dfm/0B0/+1WrRq8SvRJLXjSM+Pu0frz7lLA7Fxjed/K
X-Gm-Gg: AfdE7claXmaUsVSPkrLJjybba9yvouAbwcZcEy9oXpmlg9jJBhz5RA1KYoGUDM3NcLZ
	3uIN6tdhdPhVuNR+wieJiG1xgdDDcZ8sdzZ1igvFzA1FNrhmUeabA5rHAE05mihtpe7taJeUuEf
	EdxfjPUeXWSy5SzJkdKgYThlZmv0evofsp6LhCouHwg9S5Jt6dSf/EHDKkUHjU0xZKvUlz4b+bE
	YLFlYEftJEU2tjovd72G5/qSRSyMioEXw856nlUo+zOSNUsNsa2wW+gJ0iOFj0QlF+66sj/oAdi
	4V2vDdgdFfujieqZ9LWP4LVzxkh/G1XnpVgJHfsFGPNATvUO68FBn2dE/KFjmNBDxXtA2qn1jgW
	BLDwaacYxM1Howoi1EkrFQq6MsaA/ZNCRLuXHNGR8BgyIRI1mnhJQFX9kQocS68n3TlcBiUUcRJ
	Xow1sNBAKuoKSRLdLO+FgIGoWCTrT4t0ozuOgQZr4fJyNVp6uyXrMKk21UW0q51BE=
X-Received: by 2002:a17:907:3f89:b0:bf0:550:d9f with SMTP id a640c23a62f3a-c0b743ac8e1mr482252966b.31.1782058998924;
        Sun, 21 Jun 2026 09:23:18 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c5ef8acaesm216907366b.27.2026.06.21.09.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 09:23:17 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>,
	Muhammad Bilal <meatuni001@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: ISO: avoid NULL deref of conn in iso_conn_big_sync()
Date: Sun, 21 Jun 2026 21:23:05 +0500
Message-ID: <20260621162305.219763-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iso_conn_big_sync() drops the socket lock to call hci_get_route() and
then re-acquires it, but dereferences iso_pi(sk)->conn->hcon afterwards
without re-checking that conn is still valid.

While the lock is dropped, the connection can be torn down under the
same socket lock: iso_disconn_cfm() -> iso_conn_del() -> iso_chan_del()
sets iso_pi(sk)->conn to NULL (and the broadcast teardown path can also
clear conn->hcon on its own). When iso_conn_big_sync() re-acquires the
lock and reads conn->hcon, conn may be NULL, causing a NULL pointer
dereference (hcon is the first member of struct iso_conn).

This path is reached from iso_sock_recvmsg() for a PA-sync broadcast
sink socket (BT_SK_DEFER_SETUP | BT_SK_PA_SYNC), so the dropped-lock
window can race with connection teardown driven by controller events.

Re-validate iso_pi(sk)->conn and its hcon after re-acquiring the socket
lock and bail out if the connection went away, as already done in the
sibling iso_sock_rebind_bc().

Fixes: 7a17308c17880d ("Bluetooth: iso: Fix circular lock in iso_conn_big_sync")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 net/bluetooth/iso.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 3abd8111dda83..7186e8d88c757 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1589,6 +1589,7 @@ static void iso_conn_big_sync(struct sock *sk)
 {
 	int err;
 	struct hci_dev *hdev;
+	struct iso_conn *conn;
 	bdaddr_t src, dst;
 	u8 src_type;
 
@@ -1611,8 +1612,17 @@ static void iso_conn_big_sync(struct sock *sk)
 	hci_dev_lock(hdev);
 	lock_sock(sk);
 
+	/* The socket lock was dropped for hci_get_route(), so the connection
+	 * may have been torn down meanwhile: iso_chan_del() clears conn and
+	 * the broadcast teardown path can clear conn->hcon on its own. Check
+	 * both before dereferencing conn->hcon.
+	 */
+	conn = iso_pi(sk)->conn;
+	if (!conn || !conn->hcon)
+		goto unlock;
+
 	if (!test_and_set_bit(BT_SK_BIG_SYNC, &iso_pi(sk)->flags)) {
-		err = hci_conn_big_create_sync(hdev, iso_pi(sk)->conn->hcon,
+		err = hci_conn_big_create_sync(hdev, conn->hcon,
 					       &iso_pi(sk)->qos,
 					       iso_pi(sk)->sync_handle,
 					       iso_pi(sk)->bc_num_bis,
@@ -1621,6 +1631,7 @@ static void iso_conn_big_sync(struct sock *sk)
 			bt_dev_err(hdev, "hci_big_create_sync: %d", err);
 	}
 
+unlock:
 	release_sock(sk);
 	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
-- 
2.54.0

