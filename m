Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794314867;
	b=wSHS+uANRRJwZuZ8ucm8HhivfCNOLexmUEJQdZDy+lJI5EVbCWP2j3Ftlan1O4SX9ufH
	 SU2TDYUHOGxOWUdwMZVub1ha6RbMwXYW0oWjBKMbCs5XaotUD2qZPDtbCncJQ1m4D9gns
	 AvBBhVSlSgsu+TP5AOcIIRU3U0nw9krjEzs86RbRh7C/E/YY+/WY6liHBqrDwopM9u0xe
	 mZGv8clVpPnNoagXlu+UhmpCdolMp+aNQcNy5rjAICcFYXpytLIsK3GcGV1GjRcEU+YD+
	 hg+dQDu2rtPMDMrGJF9VXpIh0RknBaVvB+76hHCWCvjbigoYqvsY75kJDFbInX6LDJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794314867;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=TfBO+LCxAQ+g2436mdDoIGBH1lCYYEh5xPtEafTn2ck=;
	b=KDrG1UaWhT2M29OmpLUlQ8XU6/s12tb2JVT3XRDNymKnrMdHGWEmKhb+qdgYtrW6Bu9D
	 /on7L3gvvtImrAk3OMm/7NDzEO9ZcAqwSs2IDyC1KhBXmdKsDg7YgHg23pLgQM961dhAw
	 wbKPvozQJBA7pGh54K5qZUxZECL9sLncztGt3FyK7V7bdtjqfugrhqS1d23U9d3F2zjlp
	 gi5C4YwIFI0myvbOnjZrwdf/THvurafx9GoY0hUHq8BsbBwFsfsa9RxG06Lm3GLuWaCtm
	 58UFW6/P1+WoD0FVWH+s/d8B3iPj2azIAhAM+WNTH3h9n4Vo7QU9UuzKoVuvXznMFtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f1FFDOOu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDC7606A321;
	Tue, 10 Nov 2026 12:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f1FFDOOu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F98F1F0089F;
	Tue, 10 Nov 2026 12:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794314866;
	bh=TfBO+LCxAQ+g2436mdDoIGBH1lCYYEh5xPtEafTn2ck=;
	h=From:To:Cc:Subject:Date;
	b=f1FFDOOuB5wmqHPBFyeykcZsmy17UT+Ost6tqoubXHBFQq81h16aUN1JO5ilj4XKr
	 1AY/RrFu4cI8xqBJZlBo7N7fjoIUJ+pCGy053DI/Jttcl/oJhGwaSJ5AgEPvmjUZqz
	 GzWNV+keA/mnH8EL8iXDK4kzPJKN/5XecHsFV5MEuYjcJHY1FsoIrJYnRHmP5P8muh
	 YIrOe62MkIDE42xU7zntLjjIpirXNOy87a954jvmN1KNQ4KxcvFWrDm6cWsHTsD0JI
	 Ple0FqxeeE/O/gf+8z3Zsb0oYrP+ByifHOidTJqMHVHId/Q/qjqi4B6ko9qlo67C7+
	 FwuGDGB60aiBA==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] ata: libahci: Do not use an EM slot for the PMP control port
Date: Tue, 10 Nov 2026 13:47:43 +0100
Message-ID: <20261110124742.275022-2-cassel@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2450; i=cassel@kernel.org; h=from:subject; bh=iMeYow2RsAdZRduRLqWuQqAZmQ8Xox+xNjr0VleBCNw=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLI+C+W5Pl6SeJP1tVJQ2cS9QVGSLs4eK2daudkzXyyYK ieyoV2ro5SFQYyLQVZMkcX3h8v+4m73KccV79jAzGFlAhnCwMUpABMRZGdkmL3KeXFl7bzbK0Wi W3o3iRvqrBcteMK88aX9vFqbv3m3fzAyrFuaEtF8Zf3VJyJZ5jPrDrO/eKreLxQQPbnIpVJclNO AFQA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

When a Port Multiplier is attached, sata_pmp_attach() sets the pmp
number of the host link to SATA_PMP_CTRL_PORT (15), and every PMP
register access then goes through ahci_qc_issue() -> ahci_sw_activity()
on the host link. ahci_sw_activity() uses link->pmp as an index into
pp->em_priv[], which only has EM_MAX_SLOTS (15) entries, so for the
control port it ends up one past the end of the array.

Commit 1e41e693f458 ("ata: ahci: Match EM_MAX_SLOTS with
SATA_PMP_MAX_PORTS") grew em_priv[] from 8 to 15 entries for a UBSAN
report about this very index, but index 15 is still out of bounds.
UBSAN stopped complaining because &pp->em_priv[15] is now a
one-past-the-end address, which its bounds check accepts, while the
accesses through it are still out of bounds.

These accesses happen when the host link has ATA_LFLAG_SW_ACTIVITY set.
Enabling SW activity via sysfs for a disk attached directly to the port
sets the flag on the host link, and it stays set when the disk is
unplugged. If a PMP is then connected, each PMP register access makes
ahci_sw_activity() increment a counter past the end of em_priv[] and
pass the address of a nonexistent timer_list to timer_pending() and
mod_timer().

The flag cannot simply be cleared when the disk is unplugged: enclosure
LEDs belong to the bay, which is why em_priv[] is indexed by slot and
the blink policy outlives the disk, so a replacement disk in the same
bay should keep blinking.

Fixes: 18f7ba4c2f4b ("libata/ahci: enclosure management support")
Cc: stable@vger.kernel.org
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libahci.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 9e970408916d..ef760d81d1d1 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1033,11 +1033,16 @@ static void ahci_sw_activity(struct ata_link *link)
 {
 	struct ata_port *ap = link->ap;
 	struct ahci_port_priv *pp = ap->private_data;
-	struct ahci_em_priv *emp = &pp->em_priv[link->pmp];
+	struct ahci_em_priv *emp;
 
 	if (!(link->flags & ATA_LFLAG_SW_ACTIVITY))
 		return;
 
+	/* The PMP control port (SATA_PMP_CTRL_PORT) has no EM slot */
+	if (link->pmp >= EM_MAX_SLOTS)
+		return;
+
+	emp = &pp->em_priv[link->pmp];
 	emp->activity++;
 	if (!timer_pending(&emp->timer))
 		mod_timer(&emp->timer, jiffies + msecs_to_jiffies(10));
-- 
2.56.0

