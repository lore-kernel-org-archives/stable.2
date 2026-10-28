Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793177429;
	b=mgFZ7BGkGRFiO6Beh3+wt6vsVI93NBGYVrdsZieAkZcVo2K2i2pUVAhs7SssLpNMKi9y
	 /4oyNQp06/4NNSTTUKt7ZxGjGgh9NFZbcnS63H/uyBlpcsWY3hVJQ5PWDLW04OYb2Bmta
	 eZbRMm8fy39OfLVdPgkNLx5VB7oh9idgrOTUYonnIoVdQM3OG8BPQ4qOtGilt/QJJqmgh
	 QgCRD9aHxBQnZ5kzZeLFChSBCHbs/Rg9doo+c+pYLvMUrL7I1zGIERDr32cSZc4a43yIj
	 +XyVJZ8nELSIfxZe8eG6ysDPxIgtGfaW2xCj9sIfF8IgAQAj6lVoH0zNrV/j0dZwMMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793177429;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ZzkyzMXwhe6xNno6EsFST7VZQ034OlMe3wk9yXIAjBE=;
	b=0/k2HJk9DgYw2RjXwhD4lwYeQ3Xl2g5uCrCo74v2KZWfK85d/5YIedmEvTBKo+6gPsGE
	 GZm7zK+D/u2FFFVm3nhm3vvvYCvjR0AHcRDtF6gFz+nX7R1O/CpDaJYgu3ndk8Tgo+gkY
	 szjFyGw5AuaLFYn2GxM5tCYX574XR0Jikb19X2T2reFLjK1y2JnHRLl3oxzDrWQFHjxMr
	 wC7/63ANLgYoustwewBu/di+R74i76Qs0kULa3kFMFrXEmsPxxnHaavgEoCHpWG755oJ1
	 44pFfhhjJiDPtM4abdcicoC7grkqPRLQdGHTdvLgS1wIN7I9ud1yYBVrfJFR1IaFa3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1g4.org;
	spf=pass smtp.mailfrom=1g4.org;
	arc=none smtp.remote-ip=185.70.43.20
Received: from mail-4320.protonmail.ch (mail-4320.protonmail.ch [185.70.43.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B211606A31A;
	Wed, 28 Oct 2026 08:50:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B211606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail; t=1793177422; x=1793436622;
	bh=ZzkyzMXwhe6xNno6EsFST7VZQ034OlMe3wk9yXIAjBE=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Aiv/oyALvt2n3RZQkF31lOr2djiawuA5c9HAMMHEy4LA6yEqY6v3kowkl/zJKev5K
	 DpHG2UX0a2okCA3gHxrzt6frWe4oZhNA8m4mbeSSmvxiNDKKzGENE7Jm+oMMO4J5Lw
	 9dUOxcjWPEUjRYW3E78JqSbO0jXBlX1OIutdf9u5flB2JxfNcmFo/JskbET/K//T+b
	 HF7asdf3zAEPr0iob4qOo/M8Wq91Z8zWdrfA/FzD3oGhbnm3zHhAfDHm9KGjDhBmy/
	 fXMrg2jIKbNqyniUQMAc7avD0jwf/uEPPlWkrA3n+Io0BE+qU3x21/BRhTi3LnVAoi
	 Dgazhxj00nXvg==
Date: Wed, 28 Oct 2026 08:50:17 +0000
To: intel-wired-lan@lists.osuosl.org
From: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, maciej.fijalkowski@intel.com, andre.guedes@intel.com, jithu.joseph@intel.com, vedang.patel@intel.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH net v2] igc: return XSK frame copies on XDP_TX failure
Message-ID: <20261028084919.3059158-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 3c834f9f3c809d2e7ba6cca99f25171716b11d0b
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Converting an XSK buffer to an XDP frame allocates a page and returns
the original buffer to its pool. If the TX ring is full or DMA mapping
fails, igc_xdp_xmit_back() returns an error without freeing the copy.
The RX cleaner cannot release it, so the page leaks.

Return the copied frame on TX failure. Use the RX memory type so native
frames remain RX-owned on failure.

Fixes: fc9df2a0b520 ("igc: Enable RX via AF_XDP zero-copy")
Cc: stable@vger.kernel.org
Signed-off-by: Paul Moses <p@1g4.org>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
v1..v2
- Sort declarations
- Update the description to match the initialization order

v1: https://lore.kernel.org/all/20261023141317.3904442-1-p@1g4.org/

v1 testing:
Tested on Intel I225-V with baseline and patched kernels. Physical
pause-frame backpressure caused 46 leaked copies on the baseline.
With the fix, all 72 rejected copies were returned once and freed,
and all 192 copies were accounted for.

 drivers/net/ethernet/intel/igc/igc_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethern=
et/intel/igc/igc_main.c
index 1fb5f3cbe..d10dfbdb1 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2488,6 +2488,7 @@ struct igc_ring *igc_get_tx_ring(struct igc_adapter *=
adapter, int cpu)
 static int igc_xdp_xmit_back(struct igc_adapter *adapter, struct xdp_buff =
*xdp)
 {
 =09struct xdp_frame *xdpf =3D xdp_convert_buff_to_frame(xdp);
+=09enum xdp_mem_type mem_type =3D xdp->rxq->mem.type;
 =09int cpu =3D smp_processor_id();
 =09struct netdev_queue *nq;
 =09struct igc_ring *ring;
@@ -2504,6 +2505,10 @@ static int igc_xdp_xmit_back(struct igc_adapter *ada=
pter, struct xdp_buff *xdp)
 =09txq_trans_cond_update(nq);
 =09res =3D igc_xdp_init_tx_descriptor(ring, xdpf);
 =09__netif_tx_unlock(nq);
+
+=09if (res && mem_type =3D=3D MEM_TYPE_XSK_BUFF_POOL)
+=09=09xdp_return_frame(xdpf);
+
 =09return res;
 }
=20
--=20
2.56.GIT


