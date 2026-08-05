Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82912471407;
	Wed,  5 Aug 2026 13:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785936599; cv=none; b=aC9fSCDSlL+ExdD2hOGm5ORu0ho7STUMY0OCHAqKhJ57aUhS0GJfnRDSqKALIqrlXhr67VWwbUxA2S4nKZn15LG3NYgOVCHHBvCdn/RpyF0S9buZim6lVpvDkZRRnCrarI5z/3wjSo8qPVuEhwL/hyfmtukvHjJ4+rF8R63Pa/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785936599; c=relaxed/simple;
	bh=3ONLOkCCikXZjvVxIR5WZoHWXthWoxkThJGRkJtifWc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=s/79HgkEFUtbTdLsRD7Ixo4n2ieNDRCxIPWoN/aaUtws+pSoak4b2y860fpxZ0VFhOgaBsxNQVHG4RQ5dE0/aPJQ4zxi71gnqV7of+uOmkU9tsGOj7rSNJZa+uw0linY4uTDaD0qE6Prp2/ERoRaK47WAiqIWVAM5Zqlc+WY9Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OhMdl5So; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhMdl5So"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19872C19425;
	Wed,  5 Aug 2026 13:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785936599;
	bh=3ONLOkCCikXZjvVxIR5WZoHWXthWoxkThJGRkJtifWc=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=OhMdl5SoA1KA3D7f4ThuIwpq0lOBganlWQ307PueJCV2UVljEVOoi0jsewBonDbHC
	 ja37BWXUSDNMbh9m/WleOIua20iQe2nzOmVpYEkGtNku03SDKk6ZPYtUPxoxEFj255
	 LbuIRwSa7+6pJ5bDvWFu/qcrtE1JGOVhHv6xI+/o7pbGGuVeTSuM302ZtnBwgPObQI
	 RgTVZtBtKtUOXmsLsaMsY7jK+8tObOf6QT+pvgcTpEvgmUWyUE6LY9N9MxkOVXu0Kv
	 DVrnY+FUZVAVppKGPvi2x/oLN7ue6igliwf4qTpsJDU5mtpj3eQkA3SEIREDFhBsyf
	 5MBh2Ez6g3Xfw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C27C55ABF;
	Wed,  5 Aug 2026 13:29:58 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Subject: [PATCH net 0/2] ovpn: fix peer float use-after-free and key slot
 NULL deref
Date: Wed, 05 Aug 2026 21:29:35 +0800
Message-Id: <20260805-ovpn-fixes-v1-0-763f8c237fb9@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL86c2oC/x2LQQqAIBAAvxJ7TlDJsL4SHcS22ouKhgTi31s6D
 jPToGAmLLAODTJWKhQDgxoH8LcLFwo6mEFLPUsrjYg1BXHSi0UY7dViJ2OddsBDyvgL7jcI+MD
 e+wcqScLJYQAAAA==
X-Change-ID: 20260805-ovpn-fixes-52c198458a2a
To: Antonio Quartulli <antonio@openvpn.net>, 
 Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Junrui Luo <moonafterrain@outlook.com>, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1819;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=3ONLOkCCikXZjvVxIR5WZoHWXthWoxkThJGRkJtifWc=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrGKrqz3nznC0rb8yq8Hla3LLstxLLFknOe+VBMmqK
 q84xubC39lRysIgxsUgK6bIcrzg0jcL3y26W3y2JMPMYWUCGcLAxSkAE3ktzvA/ZJta7NWEVzyf
 c9atK73w2HvLnaDZ5caapxjLI/gU/MNMGRn2Xdl+dNf0C1vyUxJm7HU4tOzsoe/sHiUXgw9393F
 4ZnxjBAC5t0xf
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
Reply-To: moonafterrain@outlook.com

Two independent fixes for the ovpn driver, both in lifetime handling:
one for a crypto key slot that can legitimately be empty, one for a peer
that can be re-linked into a hash table after it has been removed.

Patch 1 fixes a NULL dereference in ovpn_crypto_kill_key(). It locates
the slot holding a given key ID by reading both cs->slots[] entries and
comparing ->key_id, without checking either pointer first. An empty slot
is a normal state: the ordinary rekey sequence - install into the
secondary slot, swap, delete the retired one - leaves primary_idx at 1
with slots[0] empty, and key_id sits at offset 0, so the first
comparison faults on a read of address 0.

Patch 2 fixes a use-after-free in the peer float path.
ovpn_peer_endpoints_update() releases peer->lock to send the float
notification, then re-acquires ovpn->lock and re-links the peer into
by_transp_addr unconditionally - even if ovpn_peer_remove() unlinked it
while the lock was not held. The teardown path never unlinks hash nodes
again, so the peer ends up freed while still on the chain, and every
later datagram walks it in ovpn_peer_get_by_transp_addr(). Reproduced
under KASAN on 7.0-rc3; the splat is included in the patch.

The two patches are independent and touch different files; they can be
applied in either order.

Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
Junrui Luo (2):
      ovpn: don't deref NULL key slot in ovpn_crypto_kill_key()
      ovpn: don't re-hash a removed peer on float

 drivers/net/ovpn/crypto.c | 6 ++++--
 drivers/net/ovpn/peer.c   | 7 ++++++-
 2 files changed, 10 insertions(+), 3 deletions(-)
---
base-commit: 075b74841bd0065a3bda3440873c747938e69b68
change-id: 20260805-ovpn-fixes-52c198458a2a

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>


