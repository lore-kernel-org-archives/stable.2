Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C02415B60
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 16:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789488335; cv=none; b=LpWwg57wZPXMpeoYg/Jbm3v460dasVV9g7Cx6IhAIiXBJ7kpl6b0fwxKh+tqnvmfDJtJHu6WHDVUPUe1VlwrWhVIADXGoYeJtDvrTF1exZtHTN8MbtPQ+AnIG+/yZ+46sWHg7oV/wFa89CKHNMLMXvD/vngoh2pmY+SOaSCmcVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789488335; c=relaxed/simple;
	bh=RS2ojj54irJqVtgopKART9dZOZwm7Vqo2VsmKNwJwzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ShXGXgQuSCGajUkM1Gl+kUCVrouLjUqatqOwaHhNtGZdWOeDDf/ke+7X+aoZqLVEPaTEny7yGa2TSJa2bpC9bXkNPR1KYTXUjGwdGehZ0NzKMKlq61fa6WfsH5xr7lnNdcTu1L7CjGler74jhMvhP5KyyjbIt8fHFMkor3qQmsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UxksmS59; arc=none smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxksmS59"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-982e8fa9171so266975241.3
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 09:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789488332; x=1790093132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PVT2cVPGriuS8ppyInO1WmGGfCQOnd1cHzGccgmMCGg=;
        b=UxksmS59bWSlPrZrFITCHh7fnjhFF5o9GSKSbYZKsg1fzk4V1yy4/SOTNVVoLKf/Wi
         KnBjFSChfKuTWqGiSX/ypPLa8uDB99N03/lPkhPQswOg0I4scmz8orIIX8upQiSDq1lp
         L5LnlowNU4geU12FkV47+Bu30A7KOhbSBVCHADBVeLmDk3800tIKcsP4awEuTrypbzW7
         315wkaImaIv1jNJiqsN3O7yWHvrHJyvbwQjnZUTd+unV0L/hxjjijv5XFSBZe86GsJQI
         +Xb5r4CeebQ2I0S3XBCW15NMLVfOQ9i86Z7tbE+/V91GGfJE/meTB6J26Rg/7z1FvE0h
         +aOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789488332; x=1790093132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PVT2cVPGriuS8ppyInO1WmGGfCQOnd1cHzGccgmMCGg=;
        b=VnLGyu6zgJQBN+oCN90nt1t4RaiupUKaV4+YBbBOgkM333ajU/yJfUmR8n8LBaRvTc
         7jPVTxFS6P4TkLJu3m02+ZyueEi08NEcc9zMBJRThQb34mK2pB7RXuxdmvvej0xX+4Xh
         48Z7R6L9fUhAH3EPwDpvupCVv836ajSfcLFIlswWjyX3EbC89ehX9g3sTOm4882fhK1R
         bZ+vA/ivP5Gvyqq3M00ekU35MaBr5Ez+KjaMATqM8fg/7HUK260XVGxrUNOVqVBgnZ5f
         c8Ilr3CmcU1D31R0Cq8E6G4x61IQFxKvttNiDRqHHxvXLsVeXKOk7Kl8ebqpBFUg7PYo
         1bjw==
X-Forwarded-Encrypted: i=1; AKwUvBzQ1xT8T9iFTd0Z2OZaqfuhJiCMa65d1A1TVN8jvROOzQdmc2OIVNjmiUEVoyVQ6iuTHYajENQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nueLVmDyLd6nvAJVXNArP/PQsPDc6qlXSwv3OTUZVZazVUialA
	pq5sh6uRfes71tH6x5k8HdmLuez01UIIMFoC8D0ah0JVMRaxfWEkkHvmKebxk2QJIEI=
X-Gm-Gg: AYBFou3IIirZ+iZItv+GIynAkxoGna3JC9xo6xootVFZ80DOimCd9S8FNxd1w5tn+va
	Scbf7IjSmWeLhnNWINIM7tQ81LBOBB5VMef0erLrnlRuJcpDfmNSm+OpBfqihZOJr9jwHgJjH+G
	wGox10dfVkdxLSY/MKWRngYcTZkEkR7aTFtjnUjp0C/rQLz2+ddl7uJP2iifVIDqKklVFflkwLU
	Q/d0YPfVgnzsJlCtuINPtfkjIZKwxE6343Y/4h8M8GeYesPAHvzHonIiuURvpaLr6/M7igyvnq8
	DTSfBiYWIhFM5TxlycKrFeJHlcKNjH7gnjXXBZX0V6+3S89MW9NcCw5El0wnbdbjxqXrg5jwP1J
	K5Cd5TZl8+JsT3kiif6+gSMMsfMXYshPaz0foVTtN16vltCBqiZIkylwcihbH0S/FWpk2a/QF4U
	m+LUSdacsIo949ArN8oE2/nOLerfWxCkaoMMeowDdJCA/kjPUnvE3cikjWRRwN/ELnzA==
X-Received: by 2002:a05:6102:578f:b0:79e:3401:403a with SMTP id ada2fe7eead31-79ed75369edmr3199196137.8.1789488332138;
        Tue, 15 Sep 2026 09:05:32 -0700 (PDT)
Received: from beelink.. ([187.13.206.89])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-79facab39basm124128137.2.2026.09.15.09.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 09:05:31 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH 2/2] Bluetooth: ISO: release unused CIS holds after channel attach
Date: Tue, 15 Sep 2026 13:04:30 -0300
Message-ID: <20260915160430.3108071-2-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915160430.3108071-1-qwe.aldo@gmail.com>
References: <20260915160430.3108071-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 net/bluetooth/iso.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index a461c8a4ef..329bee9c2e 100644
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
 
-- 
2.43.0

