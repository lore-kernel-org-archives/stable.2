Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893483D88F0;
	Fri, 24 Jul 2026 09:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784884123; cv=none; b=FZ6SCtzfpAvcqBnC88MxpnhZosYDJV1vjseRmSpePtlL7bLrS/pLccyWQF/TXc8ti0JlTIlPhjzG8M2CYdRxpOfkpJYkL1yuNFzd6UO32z5NzMgUhLuJuMIUp3lfLXiwKDhhjuGioPa3IknY84eby927ur2uqjtPINvZKEuBLRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784884123; c=relaxed/simple;
	bh=jf6ITHNc+XGuL6cCQcdNyTvYYHoEe4mW37doo2VbGCA=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=QnD2Qg0V2yu1Zo5QxXztpRiiUpDvEWj6ykU3q5PV7WvWVgWhTckgIJeyFuHJCqTMwdQSBizcxrPtW2oCb30EsVM4PsVqGIjRdZpKb+raMn8G/2cqCikAVuW7l5gx16jTm8X0NMiHsmvmfDCCOi1+POejGeQBWMko9nUomM4ZUzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=pass smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=IqkJ73tC; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyyself.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="IqkJ73tC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1784884107; bh=GB38iLMiXeS7XXXsbSFJq++xo5Xnht0g3kWb4bzP9uo=;
	h=From:To:Cc:Subject:Date;
	b=IqkJ73tCRbPmjjpkOSp4ZrytgxtZ9h5l6aQ6TV96SJ/Vw4a+CykpoUe3ZLzLzUVvo
	 T804zlCV+kMA8m84GCI8zeFK+45Rf5eeUA3K7IKuJ62j+P7LRxiHAs6m9qaxR1pCuQ
	 5DAh0miYL8kfey0WIq2SUpKSftSj43JfxLXcawmo=
Received: from localhost.localdomain ([240e:37c:2242:cf00:265e:beff:fe6a:4da1])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 2639C29; Fri, 24 Jul 2026 17:00:38 +0800
X-QQ-mid: xmsmtpt1784883638t88j0c7s1
Message-ID: <tencent_1F173E0FC1606D2AC704DC9C98AF10984607@qq.com>
X-QQ-XMAILINFO: MFkgsonL4eTufoJiNb/imNZ+jyd22tb7bFkTSfVAOTy5G27xCh2dyYYwtceMn8
	 rSxXHiq9DtokM9p7Rr3OH4raai6v6IGsGN46u0utllK070UhYr1oZKUiCxOzzz52HRIdyx598ZEZ
	 QALSEupt7dleelo+4l7aFqWLlYzOjIQhXdlVQ58ey8i2C/2ofb8BUE362UGrsL8MrQ6umOKhGd2u
	 cPbRl9JwXbEQQZhsM/+b10NnN39RaJBPwOTCfA0pT/Rk7T4YNL8MsQWJGtzCt0eHbki4cvkePckf
	 UuZv8nm3FTSzPdYdS0/gleWhum3bp6lEcRbKn2lCxMsYYRpPRfdthvCZ93SSlf6A7BPXAiyNcjdc
	 yEnHWRKo41Zo4c3QUdsa+lPbafVwQ500ilO95vkpuU69FdXAuKfyXRu7nVLw1+AWRX9eGu1RtfGP
	 S4X6qkvdIm8dfzqqz1A7OYGLvY+EVDNdtUggt5hixZAVGMGZmvYTQZ81YiTW3rxU1h0rCvip6BhC
	 c7COoIBBNhaji9DjKoQmUuCvgoEXyIQBXHlxj6v46cdsfeQisNl4JEGzGkEqHMfqy7XriABgDPs8
	 P+UxQjU4X/9/1z8GfU7u5Iz/UYyJe21PfoJakiFzc124lSRneqrNHDoHwLO+eLn8jO8K/NWeatcH
	 zdmcblFt3VzuiHkfAcUBXNdwEGzy6ihnvIPAIxJA7hwXew6quy2N1GwMD2ZCqCxL2iwdi0pml8OQ
	 Ad8goJip9svOYEIYiOvv25IROc+LcIBJgew87yJ80/ivZs8PAo1KAfl7zrBtPlv6iaElAp6fjElW
	 WZ/G0tIpwbLnqYSCCOtdOSdEgqP+SwPNhihL6jZdITI4i0e+hAirl7RbsdPV7MR1L7beszuDRn8X
	 1dOvskPAmjJLJcPEflkFmH3uyuH3d/oxxcaMB1Zq4wQpx685sty/S7vGuDIH5aOzgF1e0jAA5cGg
	 BqF8IsS11AcIVWh865K0Ee5cDmOak/Uvs3eUwsJa10c54qKaypVwwgOoKpm+BYcWUdBRsu056AaR
	 41xA38jP+GFrae0bPUeYyaiB8k9J/aVtlb4uolx/keSGliihkzojZSIyEiZq3GTc2Hu8OoME1HI8
	 2dEbJQYUAzYernqPg=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Yangyu Chen <cyy@cyyself.name>
To: Sukhdeep Singh <sukhdeeps@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Mina Almasry <almasrymina@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Lino Sanfilippo <LinoSanfilippo@gmx.de>,
	Igor Russkikh <irusskikh@marvell.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH net-next v2 0/3] net: atlantic: convert RX path to page_pool
Date: Fri, 24 Jul 2026 17:00:30 +0800
X-OQ-MSGID: <20260724090030.10273-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first two patches are standalone fixes for long-standing ring
teardown leaks and carry Cc: stable tags with their affected ranges
(patch 1: v4.11+, patch 2: v5.2+). They apply and were build- and
runtime-tested independently of each other and of the conversion in
patch 3, which is net-next material only and not tagged for stable.
Backports of patch 1 to trees without XDP support (before v5.19) only
need the xdp_frame branch dropped.

On systems where the NIC sits behind an IOMMU, the atlantic RX path
may not reach line rate: every RX buffer is allocated with
dev_alloc_pages() and mapped with dma_map_page(), then unmapped and
freed once the stack has consumed the packet. Every map/unmap is an
IOTLB/pagetable operation, and depending on the IOMMU this can
dominate the RX path at 10G rates. On an AMD Strix Halo system with a
Thunderbolt-attached QNAP QNA-T310G1S (MTU 1500, TCP over IPv6,
iperf3 -R), RX tops out at about 2.2 Gbit/s.

An earlier patch [1] worked around this by making the RX page order
tunable via a module parameter, amortizing one map/unmap over eight
pages worth of frames. The review feedback was to convert the driver
to the page_pool API instead of adding a knob. This series does that
conversion.

Patches 1 and 2 fix two long-standing teardown leaks first: TX
buffers stranded beyond the budgeted single aq_ring_tx_clean() pass
or past the frozen hw_head, and RX pages parked in consumed but not
yet refilled slots that the bounded deinit walk never visited. Both
are silent leaks today; after the conversion each stranded buffer
would hold a page_pool fragment reference and turn every interface
down into a permanently stalled pool shutdown (reproduction logs are
in the notes of both patches), so they need fixing before the
conversion lands.

Patch 3 converts the RX path to page_pool with the fragment API.
Pages are DMA-mapped once when they enter the per-ring pool
(PP_FLAG_DMA_MAP) and stay mapped while they recycle between the
driver and the stack, so steady-state RX performs no IOMMU work.
page_pool_dev_alloc_frag() takes over the sub-page splitting the
driver's hand-rolled "page flip" scheme did based on page_ref_count(),
buffer ownership becomes transfer-based, and the XDP memory model
switches to MEM_TYPE_PAGE_POOL. The diff is generated with
--histogram so the removed per-page helpers show as whole-function
deletions and aq_get_rxpages() as an in-place rewrite.

Performance, QNA-T310G1S (AQC100) behind Thunderbolt/IOMMU, MTU 1500,
TCP over IPv6, iperf3 -R:

  before:  2.24 Gbit/s
  after:   9.14 Gbit/s

matching what previously required the rxpageorder=3 workaround, but
with order-0 pages and no tunable.

Tested on the same setup: line rate with plain RX and with XDP_PASS;
XDP_TX with a MAC-swap reflector under sustained traffic; repeated
ifdown/ifup and module unload cycles under both plain RX and XDP_TX
load complete without "stalled pool shutdown" warnings or other splats.

Changes in v2 (thanks to Mina Almasry for the review):
 - split the RX deinit gap leak out of the conversion into its own
   fix (patch 2) and generate the conversion diff with --histogram so
   it reads as whole-function removals plus an in-place
   aq_get_rxpages() rewrite
 - add Cc: stable tags with the affected ranges to patches 1 and 2
 - comment the ring-before-rxq-registration ordering and its error
   unwind in aq_vec_ring_alloc()
 - aq_ring_tx_deinit(): return early instead of goto, drop the
   likely()/unlikely() annotations
 - aq_ptp_ring_alloc(): use the err_exit_xdp_rxq label instead of
   open-coding the unregister in the memory model error path
 - rebase on current net-next

[1] https://lore.kernel.org/lkml/tencent_E71C2F71D9631843941A5DF87204D1B5B509@qq.com/

v1: https://lore.kernel.org/lkml/tencent_7DB01BE7F8FA056BB5F11D3570CF636C4309@qq.com/

Yangyu Chen (3):
  net: atlantic: free stranded TX buffers on ring deinit
  net: atlantic: free RX pages of consumed but not refilled buffers
  net: atlantic: convert RX path to page_pool

 drivers/net/ethernet/aquantia/Kconfig         |   1 +
 .../ethernet/aquantia/atlantic/aq_ethtool.c   |   3 -
 .../net/ethernet/aquantia/atlantic/aq_ptp.c   |  18 +-
 .../net/ethernet/aquantia/atlantic/aq_ring.c  | 261 +++++++++---------
 .../net/ethernet/aquantia/atlantic/aq_ring.h  |   7 +-
 .../net/ethernet/aquantia/atlantic/aq_vec.c   |  23 +-
 6 files changed, 169 insertions(+), 144 deletions(-)


base-commit: 89d8006259b81dd25c962f6cc8d7ab268d6ea426
-- 
2.47.3

