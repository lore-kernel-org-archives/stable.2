Received: from mail-oo2-f37.google.com (mail-oo2-f37.google.com [74.125.231.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E033E3CB8E3
	for <stable@vger.kernel.org>; Sun, 27 Sep 2026 21:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790546392; cv=none; b=rUbBsViztjNGUQZYRXL49mgc9UBwXOI9RwtSCdpQ/ua3768dEetQwe9f6f61qTxpsH8ssAKJXqldQqu4FGCkHneN3gyAwAIUm3CMuFyxAWTz6kJffHxJOnP+H4kGKj5/n5rbOIacwGHJHLmnVaUtXOQdktgv+wDXmJwBcL1+3vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790546392; c=relaxed/simple;
	bh=qYGQCHXoEZV5jzZUL1na1NCk0N4dxc04XAI8z6cnaPs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kF+5mW4DsQblPwtRS37lCh+2WL04Wo8fHR8Up0ubc09otYYs0CuOjjWMzHTzxzvX7sKP9Y7PE1engXSACXr8XHsQD+Hbl1wdeAKYyLahgmXO0SZvZgyt/+Rqxd386dxkdbCrRJ3TyxMKgRAlZ7DL/UCjhCjPt+v3JW0f+1ZdVxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CAEssD63; arc=none smtp.client-ip=74.125.231.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAEssD63"
Received: by mail-oo2-f37.google.com with SMTP id 46e09a7af769-80032c08611so2022244a34.3
        for <stable@vger.kernel.org>; Sun, 27 Sep 2026 14:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790546386; x=1791151186; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=igAli1XIKkBSafQqyYALsMXsjZszlsyKkYv896bnSd8=;
        b=CAEssD63xSev8cIlamG9fb6OmSBYBbpP3wNsYmE9dy6b5jVMoPUOoF0huYdEzGSowt
         zNlnO19EgUh+FPrdWMLZpfKMePV9rySelzKSkepewWTNH06gSSWJhYgxQX31ufdzDHKq
         vQH8sdXkZysef+0dzEwxkVX2dDheEby7po7S2R4aEA8YYn4WzBMvgc6pR0g+pSxjHZYF
         jTenG+mDVJRSTTJdMNhk+oqbgyc6IPdg9KD7ChDVuLVn9Gwct6oV68e+IsIcqKFodemb
         oaPaFki2d1yues6ZYBxZDDsJMK1fXTPVUb2AsouUBkxTsTkGXgU10LYstRthTOyIeSeA
         xcxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790546386; x=1791151186;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=igAli1XIKkBSafQqyYALsMXsjZszlsyKkYv896bnSd8=;
        b=Mpi4dFqn4UlNbJ4Siv81t43Rk+BJJ61zP6hPYJG3rZWZMausl8AIjN7oJmBfE9KpAI
         2RbssduM7gwh5YMP85cIYIdtls4r9U+6rEJU4A/mMtxmHO97eRFRvGxrqClI8ew8nisQ
         VlmLkql8AdQXy1FXObLOaT26rtLmn0WSa/mqzY7oQ7RfFwUGgPp1ISNtpCK//PQxK51Y
         c55O+uN5a7F0vti9gCNb+pSUdOEdObNVjE1CnRl0uHFPFwJZvdGRzdOvkJzr9ZHa5uoX
         l8cHW5i250MhlB+s/gXBpHROMSTCZSjefcwawAjBQR56gWskoLTEjM1tRU4f6fWXNj5m
         Pcpw==
X-Forwarded-Encrypted: i=1; AKwUvBwa9PDjhLD0fOmI0c21ydqfgkXKP0MZBf4K6yqssdpR2c9uLDaUA7M3M0RO/VPK4IKkLYNCIPA=@vger.kernel.org
X-Gm-Message-State: AFuF++kqQku+z+YzJKq2vt7dzsBQumL/E78BK4f53aJsYHyNwFBZhJ9h
	pbP4kQTJp83MEEnpdY1jkfhjkJdD93be7HbpHimVfdyTwvpaVZBDpNNM
X-Gm-Gg: AYBFou08aWTizQcWwXiDRPmHJAWXgD29hkaPkdjiF8kjPn4OZa2mIa2Y+xbJVwm+UG+
	/9wWFCuUhC2YUR0QagpUH7BSC4nU5TZBOGgwdNVbjN5Uu05xPcs0O7/bUUQtlb9h1coJfuDhBQG
	PzfkwBV7HbUsLijb01VntVkD/v8z0eHtplLdH8EDLMU9l5zvfTjWCTC/scfh1AiTkAAFR0JMnz1
	n/QtRqYyJUjP8MApknNm2j5f6insYAg4WMdhbxqecB1prp4sBr9y9ePwfcfqi3ck6G2DybBKJnj
	n5wom2HHeH/2oEMNTeEVq6ZwpC4E0PFa+9QhUqx0oSHurcrgD9spLCs5bdPD5yfiBNmiSLNZ0fw
	zm/Dl1WPtFTIr3JZ0tMgWq6Abv3JGhEP7dFvBaxUasl1S3NUSptPCAO9pMLIUB8K9f7BJ5RGrlv
	wlDlAaL9AnXRVoNNUu6HK8CeAsdIRt3+qA9KfWLEhjGlwQPmsVqNSlHJk+tM5T7wGNfL2ejnNUe
	R7F9kwqF8juk5trHtCva7b4vlcn4ZOXcVqOd3qOJLTrzIE66KU1N9LR3DSWXnVx+TTW+YchtPo1
	QTQBbo6bdopdD8d3qYsclT8YwY7B1iCAp0ql6A/x/5/YVqfBK5Om59vv++tvzyi7fGcNSn5+X8r
	CGW0NuWAeab9NJvo86EXz
X-Received: by 2002:a4a:ee0a:0:b0:6c9:80d8:a1f3 with SMTP id 006d021491bc7-6d4410d5fa6mr10516659eaf.48.1790546385625;
        Sun, 27 Sep 2026 14:59:45 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-81b3de6f7e1sm4874147a34.22.2026.09.27.14.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 14:59:44 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH net-next v5 00/19] net: stmmac: preserve datapath state
 across MTU and resume failures
Date: Sun, 27 Sep 2026 15:59:35 -0600
Message-Id: <20260927-submit-stmmac-reset-fixes-v1-v5-0-feec6c14dd06@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43OwU7DMAwG4FeZciYocbKu5sR7oB1S19uCSIuSr
 Bqa+u545VLtUiRfLP/+7LsqnCMX9ba7q8xTLHEcpNm/7BRdwnBmHXvpFRhoDILV5dqlWHWpKQX
 SmQtXfYo3Lnqy+kDYdgg9YEAlxHfmZSbChxokOfCtquPfRKRPpvrQH9lLLHXMP8snk102/ndUy
 uj2EDx7Z5mNeT+nEL9eaUzLqQnWGGxgIFiPwJLtGLF5xtwa8xuYE4yMfOVOLkALz5hfY80G5gV
 jsmRgbzpHuMbmef4FduVD78sBAAA=
X-Change-ID: 20260921-submit-stmmac-reset-fixes-v1-7c98b92d29a9
To: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Tiezhu Yang <yangtiezhu@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Serge Semin <fancer.lancer@gmail.com>, 
 Suraj Jaiswal <quic_jsuraj@quicinc.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Joao Pinto <Joao.Pinto@synopsys.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Ong Boon Leong <boon.leong.ong@intel.com>, 
 Voon Weifeng <weifeng.voon@intel.com>, 
 "Song, Yoong Siang" <yoong.siang.song@intel.com>, 
 Linus Walleij <linusw@kernel.org>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Simon Horman <horms@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Jose Abreu <Jose.Abreu@synopsys.com>, 
 Yao Zi <me@ziyao.cc>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Richard Genoud <richard.genoud@bootlin.com>, 
 Alastair D'Silva <alastair@d-silva.org>, Maxime Ripard <mripard@kernel.org>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
 ZhaoJinming <zhaojinming@uniontech.com>, 
 Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, 
 Ding Hui <dinghui1111@163.com>, Linkui Xiao <xiaolinkui@kylinos.cn>, 
 Linkui Xiao <xiaolinkui@126.com>, linux-tegra@vger.kernel.org, 
 linux-sunxi@lists.linux.dev, James Hilliard <james.hilliard1@gmail.com>, 
 stable@vger.kernel.org, Rayagond Kokatanur <rayagond@vayavyalabs.com>, 
 Ding Hui <dinghui@lixiang.com>
X-Mailer: b4 0.15.2

Keep the stmmac datapath coherent after failed MTU changes or hardware
resume without changing the interface's administrative state. Retain the
working MTU configuration for rollback, and allow ordinary down/up
recovery when hardware cannot be restored.

This revision incorporates the following previously posted fixes as
prerequisites:

- Linkui Xiao's v3 MDIO reset GPIO fix:
  https://lore.kernel.org/r/20260921015727.2643540-1-xiaolinkui@126.com
- Ding Hui's v3 DMA descriptor allocation cleanup:
  https://lore.kernel.org/r/20260919121436.1642724-1-dinghui1111@163.com
- Lorenzo Bianconi's v3 EST series, patches 2-4:
  https://lore.kernel.org/r/20260902-stmmac-est-reapply-after-open-v3-0-e72a6df5a7ef@oss.qualcomm.com

The GPIO patch incorporates the review fixes for non-platform builds,
disabled MDIO children and resume-only resets, and drops the unnecessary
forward declaration. Ding's allocation patch is unchanged apart from our
forwarding sign-off; its deliberate omission of Fixes tags is kept.

The ownership transition and its XDP, ethtool and PM consumers land
together, so resource cleanup does not precede the power-access guards
it requires. The larger DMA shutdown change precedes MTU rollback,
rather than leaving early retained-ring commits with unsafe teardown
paths.

The ownership states remain distinct: DOWN owns no IRQs or enabled NAPI;
RUNNING has active queues; SUSPENDED retains rings and IRQs; HALTED
retains rings but has released IRQs after failed MTU rollback.
Collapsing the last two states would make close free IRQs which it no
longer owns. DMA memory ownership is tracked separately: a failed
shutdown can retain allocations even in DOWN until hardware acknowledges
a successful reset.

Jumbo rollback allocates no new buffers or IRQ registrations. RX holes
are filled before reset without changing the old descriptors;
descriptors are rebuilt or retired only after reset succeeds. If
rollback also fails, the interface remains detached until down/up
recovery. This cannot guarantee recovery from indefinitely failing
hardware.

Failed interfaces still receive hardware/PHY sleep handling. A failed
datapath with MAC WoL configured rejects suspend with -EBUSY because its
wake path is unusable; PHY-only WoL is not rejected. Platform MAC WoL
retains register, receive and timestamp power so a level wake interrupt
can be acknowledged before normal resume. PCI power transitions instead
run inside the noirq window, retaining PME/D3 wakeup. Failed PCI
restoration masks only that function's INTx source until recovery, not a
shared IRQ line. Optional platform wake resources are balanced
separately from BSP power.

Timestamp filters and PHC registration survive an MTU change. MTU reset
and the live XDP/XSK reset fallback replay the platform PTP clock
selector, frequency correction, PEROUT and EXTTS settings. Ordinary
system resume retains the timestamp initialization path and does not
replay cached PEROUT or EXTTS requests. Continuous PHC time is not
preserved across reset.

Live XDP and ethtool failures leave the administratively-up interface
detached for ordinary down/up recovery. Program attachment failures
return an error without consuming the proposed program. BPF-link and
XSK-pool removal still complete if their datapath restart fails, so
teardown can release the program or pool safely. AF_XDP pool
reconfiguration now pauses all queues and replays the MAC link while
rebuilding the rings. Successful reconfiguration leaves the PHY running
rather than powering it down and restarting autonegotiation. All queues
and other sockets are still paused while their rings are rebuilt. A
failed restart stops phylink without reconfiguring the failed MAC, then
permits ordinary down/up recovery.

Close and live XDP/XSK release now require stopped DMA process states or
a completed global reset before releasing DMA memory. Unsupported
idle-register layouts, including XGMAC and GMAC4 with more than three
channels, use the reset fallback. Replay cached L3/L4 filters, EtherType
steering, VLAN priority, preemption/TC mapping and EST before starting
DMA, with PHC replay on the reset paths described above. A datapath
replay failure enters the existing rollback or detached recovery path.

If shutdown and reset both fail, retain rings, mappings and backing
memory. AF_XDP pool teardown still completes, with independent
references keeping its DMA mapping, UMEM pages and buffer metadata
alive. DMA-owned frames are not returned to the pool's reusable free
list. A later successful down/up reset reclaims them. There is no
generic isolation guarantee for permanently unresponsive hardware:
removal reports and retains unsafe DMA allocations, which may therefore
remain pinned until reboot.

Assisted-by: Codex:gpt-6-astra
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v5:

- Keep platform MAC-WoL register access available while IRQ handlers can
  run; separate STM32 wake-clock preparation from power removal and
  retain Tegra private clocks/reset state. Publish wake handling before
  arming PMT.
- Move PCI BSP power changes into noirq while preserving PME/D3 wakeup.
  Mask function-local INTx after failed restoration until datapath
  recovery.
- Acknowledge powered timestamp interrupts while PHC access is blocked,
  including after PMT is disarmed; suppress delivery from a blocked
  clock. Balance wake-only resources and unwind a failed suspend
  callback.
- Keep frequency correction when recalculating the PHC increment.
- Retain XSK buffer metadata without delaying socket teardown, and keep
  DMA-owned RX frames off the pool free list until shutdown is
  confirmed.
- Rebuild RX buffer addresses and read-format control words after a
  successful resume reset, including page-pool holes and partial XSK
  rings.
- Target net-next and include the unmerged GPIO, allocation and EST
  work, retaining authorship, sign-offs, review history and original
  submission links. Place the EST group before PHC serialization and the
  per-queue allocation cleanup immediately before the remaining
  allocation fixes.
- Drop our MDIO GPIO patch. Keep only the allocation-lifetime additions
  not covered by Ding's per-queue allocation cleanup.
- Incorporate the GPIO acquisition guards and declaration cleanup from
  the prerequisite reviews. Cache reset resources even without
  needs_reset, because system resume calls the reset routine directly.
- Reuse Lorenzo's embedded EST state, explicit hardware enable argument
  and shared replay helper; retain transactional schedule replacement
  and replay before DMA starts, under the PTP mutex. Pass unpublished
  replacements through the same base-time and programming helper as
  reset replay.
- Return EST disable, clock-update and EST replay errors from PHC time
  adjustment. Keep the schedule locked throughout and attempt to rearm
  it even if the clock update fails.
- Preserve net-next PTP error propagation and timestamp-capability
  checks, while tracking actual clock ownership independently during
  failed PM.
- Keep the already merged open-error DMA stop and extend it with
  hardware shutdown confirmation and retained DMA memory on failure.
- Link to v4:
  https://patch.msgid.link/20260926-submit-stmmac-reset-fixes-v1-v4-0-ec1c0250b3c9@gmail.com

Changes in v4:

- Reorder prerequisites ahead of their consumers. Separate the
  independent MDIO GPIO fix and PHC/IRQ preparation, and combine
  datapath ownership with the XDP, ethtool and PM paths which must
  observe it. Keep MTU rollback last.
- Replay cached TC filters, steering, preemption mapping and EST after
  reset, with DMA held stopped until replay succeeds. Preserve the
  previous cached rule on installation failure and advance EST base time
  by whole cycles.
- Validate TAPRIO replacements without modifying the installed schedule;
  reject failed PHC reads and retain a valid cache after setup failure.
- Keep control operations from accessing unpowered registers after close
  reattaches the netdev. Permit software-only VLAN, qdisc and TC filter
  removal, and preserve open-time power recovery. Remove cached flower,
  steering and u32 rules while down or detached so reset cannot replay
  filters which TC has already deleted.
- Use phylink link replay for live XDP/XSK updates, leaving the PHY
  running on success and balancing replay with phylink_stop() on failed
  restart.
- Require a hardware idle acknowledgement or completed reset before DMA
  memory retirement on close, XDP/XSK replacement and failed open.
  Retain failed configurations for recovery, and defer IRQ TX recovery
  and resume descriptor rebuilding until shutdown/reset is confirmed.
- Add independent AF_XDP mapping/UMEM references so pool teardown can
  complete without unmapping DMA-visible memory after a shutdown
  failure. Document reset fallback and permanent-failure memory
  retention.
- Keep shared IRQ controller lines enabled during MTU replacement. Mask
  DMA sources at the device, protect DMA-handler quiescence with the
  channel lock, and drain registered handlers with synchronize_irq().
- Preserve pending DMA status while quiesced, including when hardware
  setup restores interrupt enables. Restore saved masks on restart and
  leave DMA sources masked when failed rollback releases the driver's
  IRQ handlers.
- Reuse the final TX queue and timer drain after synchronizing IRQ
  handlers.
- Restore saved RX skb ownership immediately when taking partial receive
  state, including a budget-one completion and a DMA-owned next
  descriptor.
- Cancel the EEE software timer after draining NAPI, and make GSO
  feature checks use stable platform TBS capabilities rather than
  replaceable rings.
- Reuse the MDIO reset GPIO acquired at probe and reject TC queue work
  when the datapath is not running, except for software-only filter
  deletion.
- Let carrier-down XSK TX polls complete instead of continuously
  repolling, and remove the unused external XSK wakeup declaration.
- Stop a PHY powered by prepare_resume() after failed ethtool setup.
  Publish core queue counts transactionally only after the fallible open
  work.
- Initialize rollback RX addresses before publishing descriptor
  ownership. Restore the platform PTP clock selection, frequency
  adjustment, PEROUT and EXTTS settings; serialize PHC/devlink access
  across reset and reject access to a failed retained clock.
- Freeze deferred XSK pool teardown before device PM. Track platform
  power, pending clock restoration and actual PTP clock ownership
  separately from the datapath. Avoid unpowered MAC/MDIO accesses on
  failed close-time recovery and balance clocks even after a noirq
  resume failure.
- Check unusable MAC WoL before the pending-sleep shortcut, and update
  comments for HALTED ownership and the ethtool reopen path.
- Link to v3:
  https://patch.msgid.link/20260924-submit-stmmac-reset-fixes-v1-v3-0-c031e3f3a282@gmail.com

Changes in v3:

- Snapshot debugfs queue counts under RTNL with the descriptor ownership
  check, so a reader blocked behind channel shrink uses the new
  topology.
- Complete pending core sleep state during close and retry restoration
  on open after runtime-PM acquisition. Use the installed wake state
  rather than mutable WoL settings, and retain the pending marker if
  restoration fails.
- Put the independent IRQ unwind fix first, ahead of the ownership
  changes.
- Correct the WoL/safety IRQ unwind order, fixing a repeated safety IRQ
  free and a leaked WoL handler.
- Account for live XDP release/reopen in datapath ownership. Stop DMA on
  late IRQ failure, propagate program-attach errors without losing
  program references, and allow BPF-link removal to complete after
  restart failure.
- Replace the void AF_XDP queue-enable helpers with the tracked XDP
  restart. Unmap a removed pool only after freeing its rings, undo
  failed pool attachment, and preserve TBS configuration while
  rebuilding the channels.
- Keep PHY/PM ownership across ethtool ring/channel changes, restoring
  the old configuration after failed reopening and leaving the interface
  detached for down/up recovery without a second runtime-PM put.
  Explicitly disable the MAC during release even when link resolution
  has not reached mac_link_up().
- Split the MTU work into normal-size MTU handling, allocation unwind,
  stable DMA/IRQ ownership (including timer lifetime), and the
  retained-ring transaction. Keep the ownership change and its
  open/error-path adaptations in the same patch.
- Restore the PHY advertisement reduced by phylink_suspend() when
  stopping a suspended instance, without restarting or reconfiguring the
  MAC, in response to Andrew Lunn.
- Keep suspend-owned PHY speed control separate from explicit driver
  speed-down requests, so close-time power saving does not overwrite the
  original advertisement and remains effective until the matching
  speed-up.
- Suspend a stopped PHY powered back up by phylink_prepare_resume() when
  stopping after a failed MAC resume, without repeating phy_stop().
- Add a separate MTU transaction patch retaining old DMA resources and
  IRQ registrations until replacement succeeds, following Andrew Lunn's
  request to keep the old setup for failure recovery.
- Keep DMA configuration objects at stable addresses and use persistent
  channel objects for per-queue interrupt contexts.
- Drain transmitters and post-completion NAPI poll tails before
  cancelling TX timers.
- Avoid resetting normal-size MTU changes, including all supported
  AF_XDP MTUs, and stop rebinding live pools through temporary RXQ
  objects.
- Program the new MAC receive limit before activation and restore the
  old MTU on failure; refill old RX buffer holes before reset so
  rollback does not require allocation.
- Preserve coalescing, TBS state, PHC registration and timestamp
  filters; leave a failed rollback detached with old rings retained for
  close.
- Harden partial-allocation unwind.
- Separate core sleep completion from datapath ownership so failed MTU
  and resume paths still receive hardware PM handling, without disabling
  NAPI twice or restarting released queues. Address the skipped-suspend
  issue reported by Sashiko; reject an unusable MAC WoL path with
  -EBUSY.
- Balance platform noirq PTP clock handling against resources still
  owned after detached XDP cleanup.
- Link to v2:
  https://patch.msgid.link/20260922-submit-stmmac-reset-fixes-v1-v2-0-d92e609be996@gmail.com

Changes in v2:

- Drop forced netif_close() and retain the interface's administrative
  state, as requested by Maxime Chevallier.
- Separate queue quiescence from resource release and use explicit
  datapath state instead of a napi_disabled argument to the release
  helper.
- Handle repeated suspend/resume after failure, preserve PHY/PM
  ownership until ordinary close, and allow a fresh down/up recovery.
- Check XDP/AF_XDP cleanup, descriptor readback and asynchronous reset
  work while the netdev is administratively up but unavailable.
- Explain the generic phylink suspend-to-stop transition and why
  restarting phylink after a failed MAC resume is not a valid
  substitute, in response to Andrew Lunn.
- Combine the two stmmac error-path fixes so every user of the new state
  has consistent resource and NAPI lifetime handling in one patch.
- Link to v1:
  https://patch.msgid.link/20260921-submit-stmmac-reset-fixes-v1-v1-0-87a4e431ee00@gmail.com

To: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>
To: Serge Semin <fancer.lancer@gmail.com>
To: Suraj Jaiswal <quic_jsuraj@quicinc.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: Linus Walleij <linusw@kernel.org>
To: Russell King <linux@armlinux.org.uk>
To: Heiner Kallweit <hkallweit1@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Magnus Karlsson <magnus.karlsson@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Stanislav Fomichev <sdf@fomichev.me>
To: Simon Horman <horms@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
To: Jesper Dangaard Brouer <hawk@kernel.org>
To: John Fastabend <john.fastabend@gmail.com>
To: Björn Töpel <bjorn@kernel.org>
To: Richard Cochran <richardcochran@gmail.com>
To: Jose Abreu <Jose.Abreu@synopsys.com>
To: Christian Marangi <ansuelsmth@gmail.com>
To: Joao Pinto <Joao.Pinto@synopsys.com>
To: Yao Zi <me@ziyao.cc>
To: Thierry Reding <thierry.reding@kernel.org>
To: Jonathan Hunter <jonathanh@nvidia.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
To: Ong Boon Leong <boon.leong.ong@intel.com>
To: Voon Weifeng <weifeng.voon@intel.com>
To: "Song, Yoong Siang" <yoong.siang.song@intel.com>
To: Chen-Yu Tsai <wens@kernel.org>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Samuel Holland <samuel@sholland.org>
Cc: netdev@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: bpf@vger.kernel.org
Cc: linux-tegra@vger.kernel.org
Cc: linux-sunxi@lists.linux.dev

---
Ding Hui (1):
      net: stmmac: fix error path cleanup in DMA descriptor ring allocation

James Hilliard (14):
      net: stmmac: unwind the WoL IRQ after a safety IRQ request failure
      net: phylink: allow stopping a suspended instance
      xsk: freeze deferred pool teardown during system sleep
      net: stmmac: serialize and retain PHC configuration across reset
      net: stmmac: leave the datapath running for normal-size MTU changes
      net: stmmac: complete DMA configuration allocation unwind
      net: stmmac: keep DMA configurations at stable addresses
      net: stmmac: track datapath and power ownership across failed reopening
      net: stmmac: use the tracked datapath restart for XSK pool changes
      net: stmmac: restore TC offloads before restarting DMA
      xsk: allow drivers to retain DMA mappings independently of pools
      net: stmmac: retain DMA memory until hardware shutdown completes
      net: stmmac: prepare device-local DMA interrupt quiescence
      net: stmmac: retain DMA resources across MTU changes

Linkui Xiao (1):
      net: stmmac: request the MDIO reset GPIO only once

Lorenzo Bianconi (3):
      net: stmmac: embed struct stmmac_est in stmmac_priv struct
      net: stmmac: pass the desired EST enable state to est_configure()
      net: stmmac: re-apply taprio offload in __stmmac_open() and stmmac_resume()

 drivers/net/ethernet/stmicro/stmmac/chain_mode.c   |    6 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c  |    2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-loongson.c   |    2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-motorcomm.c  |    2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c  |   18 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  |   28 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c  |   27 +-
 .../net/ethernet/stmicro/stmmac/dwmac1000_core.c   |    4 +
 .../net/ethernet/stmicro/stmmac/dwmac1000_dma.c    |    2 +
 drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c |    2 +
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c   |    4 +
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h   |    8 +
 drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c   |   29 +
 drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h    |    4 +
 drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c    |   30 +
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c |   11 +
 drivers/net/ethernet/stmicro/stmmac/hwif.h         |   11 +-
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c    |    4 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |   70 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_est.c   |   49 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_est.h   |   13 +
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |   15 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c   |    1 +
 .../net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c  |   10 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 1912 +++++++++++++++-----
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c  |   65 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c   |    2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c   |    3 +-
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |   40 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c   |  190 +-
 .../net/ethernet/stmicro/stmmac/stmmac_selftests.c |    8 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c    |  375 ++--
 drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c  |    6 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c   |   83 +-
 drivers/net/phy/phylink.c                          |   51 +-
 include/linux/stmmac.h                             |    7 +
 include/net/xdp_sock_drv.h                         |   25 +
 include/net/xsk_buff_pool.h                        |    7 +
 net/xdp/xsk_buff_pool.c                            |   72 +-
 39 files changed, 2390 insertions(+), 808 deletions(-)
---
base-commit: 014d795c73837ea2339a4ea8e8f82c6e959b845d
change-id: 20260921-submit-stmmac-reset-fixes-v1-7c98b92d29a9

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

