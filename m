Received: from sonic301-22.consmr.mail.ir2.yahoo.com (sonic301-22.consmr.mail.ir2.yahoo.com [77.238.176.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020C3428475
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 22:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.176.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790290375; cv=none; b=KkoLTePz70k2e5KOT6DOf91X6ksXjOgMkGV+R9ktgisNulPmK39vlK7A1BzcqASSRHCwONFYnNXKNu3r+OxngX4mMS4ObqTJYzCJLeEK0wvCM/VQ1WlYqhJOHjv6RsLH856QFvLCvU440JqHbT2NX//vG/wUl1To/W6N6UsJ6eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790290375; c=relaxed/simple;
	bh=sLZ2f3qmkmQP40OEduwbrkPI3sTryjrODxdy8yYGMyg=;
	h=Date:From:To:Cc:Message-ID:References:Subject:MIME-Version:
	 Content-Type; b=TaCXSMpPqv/aK1JPBObPtdUc7ZaZqfb6TNfNnpTbdzIweAaZmek4zD+iYy5/eD8epEjCPCwlPNi+Xhcsd2AN3tFYJYjNmk/iV6o7j2LxBbJBvF0BszjOwODKxTWMuvQuRsBdENEqF+k5I4b37gQQrFf8W4EqM42w/3ypNYHiIak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ymail.com; spf=pass smtp.mailfrom=ymail.com; dkim=pass (2048-bit key) header.d=ymail.com header.i=@ymail.com header.b=pR/gl+eA; arc=none smtp.client-ip=77.238.176.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ymail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ymail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ymail.com header.i=@ymail.com header.b="pR/gl+eA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ymail.com; s=s2048; t=1790290365; bh=sLZ2f3qmkmQP40OEduwbrkPI3sTryjrODxdy8yYGMyg=; h=Date:From:To:Cc:References:Subject:From:Subject:Reply-To; b=pR/gl+eABl6qk5Gs/xQGyJkgeaWqTVQEERCRwNX1TA0xydEYGwJxI3I0lmpZ6JgZB9nQ3SeaBAvacZHw9m5PcbLudZExhcKIX9jzDX3NX7+saSBn7NQQ97VChRpy7pVJ28e2lLn35STmzY4E3wnC83DNC4D8ZHwPQH94vPVAgRy6uFq/aBlYadnQcm4PdVKe5OElOKQZO0BTD//NV8ncxoFlQbGTZ64LHR6Qjt+ON7sr0MPjPDHGtjUivX2v3j9C6gaVvGlgjYWRX6LMzU2B32wHXn67XK44KUYrarI5rztjYPeOxjpu0+spB+WsrVVERnY8PULjkUQtRrtC0EQ4vw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1790290365; bh=asUaaEONd7F9dRtGEHUv6RN9+n0WatlEM5WXTR+02Wg=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=DbB2sFzRDNwzR52hXsC6wPg5CxMguOrN8gWvl42hPUthdPDtqK3CwMKtngbueHZMCPkypFalMJI2ECYsnbQX4tTV/Ucb9jtBJPvYw1n6xd7oLlBbAL7OWOneXQer/46vfuIn3I+kjbIGW05Ez1MzuKwZ7q3mm0VRzmoKDsIVECfsewyeL6k7IMWYiCYpqmrOT3Px6Dl6RP8unVlL3Be/qXSOVhApI16zm3uwUtRNMzCuTSB0UB93v+fnAYUjZNfm6D4r9pUu3xuJqRXo1gXfV5hwaVt/ajCXBXpBEyqbTLw8LtaLz60/7TWnn4+9PvEBrO3vi4QUXZETgovxSpdoCg==
X-YMail-OSG: MudnEewVM1kCG9By9l7Isqrkg15R_DFcw7O2SdpvA1ZkJoQbp5pyrlz.VVP7oTK
 xULu0sAz5SIVC2Xt5.3bUjkcy6uSSrnKWDPmz_27pc2XuE4uXjSkgkPRjy7ZEBIS0CljOOfI_JcR
 q3Yve.QRC7lX2bOC7Y_mbNUiHkAEzDWkvFkk5InKE3lQrfIZHRC.LKPJsO3HbvbA9AfSdwAuporr
 YYiRZJKV.pDMpVES3X53WNof_aVsAD6cVkKgMu18BNlRRWxSwOf1WFIWZn22krcKyQmnEza8TSqz
 T7a8xnu0fZMHYVuCp9NTZdG_xv5vKYfx8EPV2D6DNjrWQhSZ6Xm_YRlG2MtoWgZPoCRxRdOFQL_G
 C8XGfCr_Xr6xFbKZuBHf9Exr1PY2WHSdIv5cugmKFB.lKnHHqyDdtxAkYmyTv62UUwirQQO0XW4t
 37PcXtwOQM.Su_SesIB1AeifZA0q1.bWbtFGa4yGNsr_nlYf2lxz17HWCcwI24A_ppanlgLwu_Uz
 nhG1wmCoLqVU1Kq7vryxRNAI5fEyYyfNQIKUSE8lYzBuVdZ2pjHGFXRCHemSW__Jdaf_.yoZ0T3U
 3HzITtII.jiXCIgjt50vOl9_4pLiZjuo1dRdhZXN1h_0LkMcPYbhThrteFiDIpCVbaKg5P8aMvUd
 pWMG.WzBCIx24jrj6geHR95.qjWCPnc8DRRh8HkKL8b7tsJWSovz5CFQGuPvHd5HXrnbnyF3SJMR
 he5smS5uq_7n4lAteWPVYOqmCWsH7HB_KuMxgZsZ3dWklsJ5pX9LFMHq9VblyjcYYFZowgg.oAwL
 5qxjEQKMWCPl.mWjjt2r1Ihd1nuSINEZPR63uPWCozt0YKeJpy2riCSODhHsWp1FVlzyKHOCjYGx
 5isPLheFCg8gBZhUCqqJtMQ5w9h0tq9vEB0gA1TYxAelRctZDnu8iytE7a6OG_USyweOZZhasPEo
 qunXFcST0iQKcxILkUkrtBxZOnbZIZDmQT.Q49TMHkfBl4WC1gSCeeHsDtabQAN0HPARsBiw7iEa
 timUPTgO3NWrYm86eViybhrBUcKUgZs64Np6ALkKREh.lw7waYqxSHVhIRx9iItgU2quQKq2P.F7
 UsPDGopa.1gmxw9SB5GG0Bvhdvd12uIz7y9DiZeChn7eUOTmaHgmMVC0_hY5HWjgFjZZhWxdJ.mR
 RmAf915vKplJDFkVgGXIR0MNbFz_Ty9kgsE3_0tFXI.bjXo5NmI7GIwsQZM.kFTffcE0yZz1jq.u
 qDyeVqi.ejkgyOOqrLdQAYq9eeaZZ.RcFuomXghb_l4kNvMDpj1ZKYHP.QS4bgO9GCKDb0O5f7Nd
 xtK7BdM4HxvLaBiDkreTD_SURiy9MLs7te6vH_va_uQIimY3rN1Njo.4Bdk.Ky567mXv6r22pUvE
 C2z2M7yeFsWnS9kihjA2PqVPTY4WAWH.UHEbF3uqatjor5mAxSNU72XPax72CwJVgSg_v8y8vTpB
 SLzwf50OgBZUkOva5InI83cMBxs.9H1ShEpgcya4Zu2ao_VqAd1zCGtQmVqBiq1aSwMGuSpbLXmQ
 1ru2PXAjyrtKGKUp.TP_nMkv9XwPRs2ZmaCGj5y3Mc0U1z.dk_s6lrtZupXTwHQ7isuGRVlgvG4a
 hGPeiu5VwLl0r1j_NcLJT9LCKAZPCQ.n0wsojQ9kQYpR1UQhzO4pm.o16Cs7d87zKR4O.LB6UmyP
 x80oQvVwg9B_sX9wjQptpp4OA65VIJzBgU0.oPvq6UDTsOM5wGkheDq28GakKqQmMtKCO4fAREKF
 PyS0cZfYLhCFgqNoOJ0kH9hks7vU_mxxUfku33LdtiOHwxrPP_gi0DL.cjUNPlQd4aCcAAXCXtDX
 HpxESsf.f8DbZxj5IM8zeW8hkDuvGho1S9UW8oEHL_AUzJHfAJiYEsefxHHZavySYlvavxdtKNKL
 IwskReFirkuC76Ju5DoZE_uLLMlaiqqHH0LSpTad40hHl54ONpd6QvNPHjS_8ymNxBnbgn8wnOY_
 8BYY7XZb.zmgU0MIMpAJqC47ZBntoLZ_V1T0wvC8Qzja3n0pBbrGdFDbEOoD9l9ZuyD5RIUI8Pk5
 JYxjtnaAHpcavz8f16VBDo3uG7U2gK1.9mkAWKT_UIlzKIoeQjXOAV24zKsqQaRwANu5JT1snQSD
 S60BDIhKBXMqaakEDBjAZqUi8LmmiO9.UOe0pzp8OSM1q19dXhO9Nr.ZzvrDx_.hwp2A51Kc0mzT
 CSqq_06y4zGgRODg2NFbDL.SYATgRjU6mGz2mLSpodVW2E00TmH7MMkHZh0s-
X-Sonic-MF: <d.piecha@ymail.com>
X-Sonic-ID: 38cb62ca-ffc3-44fe-9710-c77ec00c410a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ir2.yahoo.com with HTTP; Thu, 24 Sep 2026 22:52:45 +0000
Date: Thu, 24 Sep 2026 22:51:23 +0000 (UTC)
From: Dennis Piecha <d.piecha@ymail.com>
To: "hkallweit1@gmail.com" <hkallweit1@gmail.com>, 
	"nic_swsd@realtek.com" <nic_swsd@realtek.com>, 
	"o.rempel@pengutronix.de" <o.rempel@pengutronix.de>
Cc: "andrew@lunn.ch" <andrew@lunn.ch>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"kuba@kernel.org" <kuba@kernel.org>, 
	"nb@tipi-net.de" <nb@tipi-net.de>
Message-ID: <353419280.954808.1790290283530@mail.yahoo.com>
References: <353419280.954808.1790290283530.ref@mail.yahoo.com>
Subject: [REGRESSION] r8169: RTL8168h silent RX stall with EEE after "net:
 phy: realtek: fix EEE advertisement write on the internal PHY MMD path"
 (6.18.y)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26577 YMailNovation

Hi,

after updating from 6.18.39 to 6.18.52 (Home Assistant OS 18.2 -> 18.3,
close to vanilla stable), the onboard RTL8168h of my NUC silently stops
receiving every ~7-20 minutes. Disabling EEE at runtime makes it stable
again, so I suspect the stable backport of

202fef9bbbf5 ("net: phy: realtek: fix EEE advertisement write on the
internal PHY MMD path")

(0af3afd054e7 in 6.18.y). There are no changes to r8169_main.c between
6.18.39 and 6.18.52, but this PHY fix touches rtlgen_write_mmd(), which
is used by the "Generic FE-GE Realtek PHY" bound to this NIC. My
guess: with the advertisement write now landing, EEE actually gets
negotiated with the link partner, and RTL8168h doesn't handle LPI
correctly on the RX side. The fix itself looks correct to me; it seems
to expose an existing r8169/RTL8168h problem.

Hardware:
Intel NUC11ATKPE, BIOS ATJSLCPX.0039.2023.0221.1502
RTL8168h/8111h, 10ec:8168 (subsys 8086:3027), XID 541
PHY: Generic FE-GE Realtek PHY
link partner: AVM FRITZ!Box 6690 Cable, 1000/Full, flow control off
no VLANs, ASPM already disabled on the device (LnkCtl ASPM bits 0)

EEE state on 6.18.52 (read via ETHTOOL_GEEE):
supported=0x28 advertised=0x28 lp_advertised=0x28
eee_active=1 eee_enabled=1 tx_lpi_enabled=1 tx_lpi_timer=12

Symptom: carrier stays up, nothing at all is logged by r8169 or phylib,
no NETDEV WATCHDOG. rx_packets freezes while TX and the MSI-X interrupt
count keep going; no RX error/missed/dropped counters move:

time rx_packets tx_packets irq bql_inflight tx_timeout
23:08:29 626373 188818 201071 0 0
23:08:31 626458 188908 201236 0 0
23:08:34 626513 189037 201394 0 0 <- stall
23:08:37 626513 189126 201473 0 0
23:08:44 626513 189284 201606 0 0
23:08:51 626513 189517 201788 0 0

It never recovers by itself. "ip link set eno1 down; ip link set eno1 up"
restores traffic within 3 s; flushing the neighbour table does not help.
Disabling TX checksum offload and pinning MTU 1500 (workaround for the
VLAN-related TX timeouts reported by others on the same update) has no
effect here.

EEE test: on a 6.18.52 boot that had stalled at ~7 min and again ~7 min
later, I disabled EEE via ETHTOOL_SEEE (eee_active=0 afterwards). Since
then it has run for 60+ minutes without a stall, nothing else changed.

What I have NOT done yet: verified the EEE state on 6.18.39 for
comparison, and tested 6.18.52 with the commit reverted. I can do the
former easily; building a kernel is harder on this appliance-style OS
but possible if needed. I can also capture a MAC register dump
(ETHTOOL_GREGS) during a stall if that helps.

Original patch thread:
https://lore.kernel.org/all/20260806134716.3511821-1-o.rempel@pengutronix.de/

Downstream report with more detail:
https://github.com/home-assistant/operating-system/issues/5042

#regzbot introduced: 202fef9bbbf5

Thanks,
Dennis Piecha
