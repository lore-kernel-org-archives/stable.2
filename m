Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795425447;
	b=3JRQqac0PqBS/CCWehBC+0kkp5mxtR29ToqT6exdtbAbwWIBv5/16TkVH2apNxFj6Z8t
	 qTt5DDbQ6DuW6Ohrycnt/eA/whLYVFodxoUxUG6YT7gPMe9oWo//axS28BrRN+zptBMis
	 iQI7XFpoDkK1r5rCCWiS0I8i6l+vAOKMF2rrr5B2vizkuTNJrdR47PWsnOr4Hypwf4S16
	 kMV2mBSmdV6dXPvmqBjLpU4XQi9tWo9kk0kHGercOstHMDqlEdlL1Ab5fPtbk98Lk6CA9
	 vHL3NT8lrNNSLlHNbBIadi7VFzT7Dy6p6Ry4kjC5b2lzAJMvuWrNJoRCXOBHcwZhX5w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795425447;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:CC:X-Mailer:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=mFWMcEq0A2KYP6XuDqI4w4rCF7exJvYvPu4K6lEomaI=;
	b=VcuTW9O6qlV3q4OlsZchZmh8P7+zJuRpdzmr/5pWAzr89eIr+AwGw+1TXIA1W9v6pU/s
	 cbnmI7AukGoqktUB8AuuTbyTUkKwWUndCojycq0lSrC4paUjRb5p21/pX8o2WK6lEVCrE
	 hBo890GAYX1nfexZ/4v8Y/2ckGjwkEfiacJcWLI1MllkEggdNgtJeNaz49EKaR8ANlv3/
	 d1rGWE0mhyOw8bfcHcU2GPwnFj7YAuMAfw7FHpB8LswwSr1DswKU7cVGs+QRXm4gAI+M+
	 AtQPm4mT/hp1fZid/MdF3zUupBC4UXaZkMJKA2WwBigeuJuq83nz5mCE8crG1AJR09w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=TVW6E5zl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.49
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011049.outbound.protection.outlook.com [40.107.130.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C252E606A31E;
	Mon, 23 Nov 2026 09:17:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C252E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=TVW6E5zl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ueEip6qXODUZw8Ul6q9goviS0rKMOpwQGBotIdtEFHqtmO5klLoh9OsdZOD7swVj9gVOCX0oU2h27Ae2BW+UIzIblwBw/dQ5/4dS429aUvAdzlS1Jhjzg+nxXrw4qmP2SoMJq645zQ9+401MpfSUN0p9Cr2bSvTiLlT6sKVTZa/q5MvPyutMCVXD4Ha2pnwBpLf3YylDJpVnwuvb/bEE343qfl5+n4ixmTNxs30NJh6UpTo9iBUBm8rbL/madHFNbGxj6LNe+TXLaH2JyV/mPq/WJJol6n0s2SGNeCE1LiMG6S4PzbznwUyfT9XrvvykwSlFNQAiWUjPILXIaUjOCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFWMcEq0A2KYP6XuDqI4w4rCF7exJvYvPu4K6lEomaI=;
 b=YW9VG4WHSS8Z27eL5DgnkixDftg0hLJ1xwbYMr+5Kr7kBijGQjWrxH4ecWwscQ5xkn5MJAiJPYsQu5cn8ykc4fTvyqMpJIBjY2uXN0RBg6yo7MxzL3MLdOEHDbBOg/84bQFft9Omg71gt+X6kxXs3lrvsjTu7BmeXxHlFeV4LOOBFdZXDJswO6u2mg3sufl3ap6OnKidFNno8oIW6nAgq5cfl94j1/ASQwcaazTmMLAi+NVsDrDCjtcCIKBGZFKhFmkR+uCLmOLLhFYrSqVbWRoI25MtY7o9NTcvoBclaCSE7qhZO6NMuN0un7rvC0CYRhhR/6Xy7aKb+k2Lbyscpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFWMcEq0A2KYP6XuDqI4w4rCF7exJvYvPu4K6lEomaI=;
 b=TVW6E5zlUq5c9JoKFF3bvwcCxJeaK0IRHLs+K2ZUlBMVbGGqba4FcR7JdXzDoiX0k9KK+qqQ/Jcd7ZfTVE7yb1eAzvSLg9bBOhbL4NHcVImp9BGV17EadjFHo1bZA4BOXygWdn1AE9AYXhlAcgw44SWU4p/hYCp8h07XdTAyxa/wkKgWg5n6jENTJstv8gsmdxvjBtjOrsr5Nu81lrTiy4B61ioMgGPpSjZZaJY46wTjrITWuwXwpDK76kACROfyebnXwSuQK5LOlWVHOviH2ByrcPjrgF7LgyiBnLojfvLQF2q47g9EYJk+7bk6S2sDO5h3FmR44be7SIMBkNWX7g==
Received: from AS9P250CA0020.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:532::22)
 by FRWPR10MB9420.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:d10:1a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.3; Mon, 23 Nov
 2026 09:17:20 +0000
Received: from AMS1EPF0000009B.eurprd02.prod.outlook.com
 (2603:10a6:20b:532:cafe::6e) by AS9P250CA0020.outlook.office365.com
 (2603:10a6:20b:532::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Mon,
 23 Nov 2026 09:17:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AMS1EPF0000009B.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 23 Nov 2026 09:17:20 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 23 Nov
 2026 10:18:07 +0100
Received: from localhost (10.48.87.222) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 23 Nov
 2026 10:17:19 +0100
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [PATCH v2 0/4] dmaengine: stm32-dma3: fix IRQ flag race and
 linked-list handling
Date: Mon, 23 Nov 2026 10:17:04 +0100
Message-ID: <20261123-dma3-fixes-v2-0-0a5b013f79d2@foss.st.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJAEBGsC/02MTQ7CIBBGr9LMWhoGTA2uvIfpgsBgZ9FimIZom
 t5dbFy4fN/P20CoMAlcuw0KVRbOSwNz6iBMfnmQ4tgYjDYDIjoVZ29V4heJikOwRBh99Bra4Vn
 oKNr+PjaeWNZc3oe74jf9aYz+11RUWiXjAqazvVjnbimL9LL2Ic8w7vv+AYIypMGmAAAA
X-Change-ID: 20261119-dma3-fixes-d6c3ee1dada0
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, =?utf-8?q?Am=C3=A9lie_Delaunay?=
	<amelie.delaunay@foss.st.com>
CC: <dmaengine@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Jerome Audu <jerome.audu@st.com>, <stable@vger.kernel.org>, Frank Li
	<Frank.Li@nxp.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000009B:EE_|FRWPR10MB9420:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e7a6c95-528e-45d7-cacd-08df494293a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|6133799003|18002099003|13003099007|11063799006|56012099006|261028144727099003|261026121527099003|261026140227099003|261102123227099003|261022075727099003|261021123027099003|261021121427099003|261022105027099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	q3zqk/scH0/dFxOq8XaY1gM+d+rh6yzq9V+j3Psnp5RmjLgW1EAg3jg/r7mSv8cm7uWR38kbVoyJgTMuP0RVtYyne18rU8YdbCBXhNoNO82t+0XK9YsAERVnP6OVanbSHhQYgoS4Y9RZgfHLA20ZGP/onKtnpfuzZBHZr7emxJlLkgJMnuNzuTiDpvelW/SkyNN1ntc5GVGsSNDAicAd1VW34A9D+LAfBOIAPc1UpQd4oEQnuEfXZpYUtO0tD1t5m/fqRKcC2eLFV3zDth1jyvnVF0FpWmtQoyJQ1Beun0SIcwR5BEwEhyIaApxzWn+3weTlAujx+4Ic7CYu+1yabYJ7+fUOavQWzpb9Rlh/EtBtMvuZAFITW4Or6an2bpq9SCflIQWciAVUEEGiD9bNsf32cwzYc/AXtIl2JYuONf4hTItvX/6QXDraAcdemPO4LeYu5kmy/6E8RiAAM4ibF0sTtmjCo0G45mEEYvhQNN8l08jZ26HnMVZV9lLjpUqQnjoGbspe6e7/K2duz6Wj1wYmIm9JD6QZUc/KlclP0apoEo1kgTDXdwwmb/c612ZV8UMwzs7lGnbpPCoI1TM+qZyke4nk2J8JZc3enZrZEIJ300Ii5TibvVIFpAM1QBFMGvheUEmplcoRfdG34zvP8KeAUBjpEfVye2qVgxzFggI=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(6133799003)(18002099003)(13003099007)(11063799006)(56012099006)(261028144727099003)(261026121527099003)(261026140227099003)(261102123227099003)(261022075727099003)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DUGozIcyxY9UhjuUOeMj2pqWcGprwhiB6RqqAEydXWUfNgwxwL5T40Anu71TvJuDOQLcvaEhvLhVGOrQZoLy9lDBcQtGe+oVKaicNxdxNymikMrJAJzKyegliUhSRyJPpb+bYvvGZ0EpsC14FIlgiYOo3crVbPEFxy5G7dHPdqOUNU3vNP2WqeN6Lnypq/UDlPTyifdzvQcoXH6XjnkiObFg0P6oUjYHQmaI2jwq5bgXzXH+5K7kNIQosTDfwmHR2/tunWoETBu20AWL5qlZDXVS5lsi2gd+tsxylxQjtzvPLizk43EUhr2z0enmksQZe6JOSuPH5IPL3OIk15Zz+1UyImTumQ0nW7FXkMjyLx8/HqnHF1Z8f/pyIkXRG4yjAotnamXrGbqB8edGd4KzJ+GpjZdQiw6CFAemLZkfgD+UKn02igVrLZ1ERtzcaNXU
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 09:17:20.2979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e7a6c95-528e-45d7-cacd-08df494293a6
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000009B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR10MB9420

This series fixes issues in the STM32 DMA3 driver around transfer
completion and linked-list (LL) handling, plus a related cleanup.

- Patch 1: clear channel flags before handling completion, so the
  Transfer Complete flag of a new transfer started from the completion
  path is no longer cleared, which could lead to a timeout.
- Patch 2: write the LL base address (CxLBAR) when starting a transfer
  rather than at allocation, as other transfers prepared in between could
  change it.
- Patch 3: reject linked lists spanning several 64 KiB windows, since
  CLBAR provides the common upper address bits. Lists may now fail to be
  prepared when crossing a 64KiB boundary, which is preferable to
  the hardware fetching descriptors from the wrong addresses.
- Patch 4: cleanup, derive the descriptor size from the structure and
  correct the maximum descriptor count to (CLLR_LA / size) + 1.

Patches 1 to 3 fix issues present since the driver was introduced and
are marked for stable.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
Changes in v2:
- Address Frank Li's feedback: rewrite Patch 1 description more clearly
  and add a blank line to separate paragraph in Patch 2 description.
- Link to v1: https://patch.msgid.link/20261120-dma3-fixes-v1-0-f29c1f437399@foss.st.com

---
Amelie Delaunay (3):
      dmaengine: stm32-dma3: set LL base address when transfer starts
      dmaengine: stm32-dma3: validate LLI pool allocations and fix cleanup
      dmaengine: stm32-dma3: replace hardcoded LLI size with aligned descriptor size

Jerome Audu (1):
      dmaengine: stm32-dma3: clear flags before signaling transfer completion

 drivers/dma/stm32/stm32-dma3.c | 78 ++++++++++++++++++++++++++----------------
 1 file changed, 49 insertions(+), 29 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261119-dma3-fixes-d6c3ee1dada0

Best regards,
--  
Amelie Delaunay <amelie.delaunay@foss.st.com>

