Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011010.outbound.protection.outlook.com [40.107.208.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E08344DB7;
	Wed, 30 Sep 2026 06:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790748144; cv=fail; b=g2Aqymxqz0qVTMUMw8Q79/z67Oymyet1vXAdC1yvSTemmNtJZyXwbrj8wSxZvykvmnyVEhBmTsT/d1D48V0hyyeizBH6ujc86/oe3RzOxXMNul7O+W9zxEo7f5WYZJjTd6CUbMNCXlkifnZ+LK52p3R2ZlKrLO/dM4D460i9Na4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790748144; c=relaxed/simple;
	bh=cc3Bo3Xg4Riu1VtcjFEWlxskgikXa1T72dYOBxIPWhE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FD10pm87UtfMICi+nzW6ncVzKFhMjzIKtJ2O1hZrF0cBAvgXJWdbBmY95+jS7UNIUlPG0Q6b7AXFVAN1HtBUMy/YltGZD52/52ekWra/uOig7P5L4Zmo9sxjlBOBvUh6ga4EVZc6rWD0AB0nnNsNHZPsruLLPaIGuB5HYCwfK0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=appgate.com; spf=pass smtp.mailfrom=appgate.com; dkim=pass (1024-bit key) header.d=appgate.com header.i=@appgate.com header.b=V6cIfd3H; arc=fail smtp.client-ip=40.107.208.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=appgate.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=appgate.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=appgate.com header.i=@appgate.com header.b="V6cIfd3H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vl8kvsERn/NDE1cyhflizUaOtWSrlVjXDHLxDTsRh1HwmLNncRU7ZwKIFYxtlRteaI13769jvLUx6N9qq6Z4svr/Jd5ndDoqQ8zC/KCPcDyXeywSP56Wsl9gmI88Oyaxg7Lf+hX64G6cO8x5AKZQpewH0FOpHwQeNpe+z1khkFncAnZIgOaH8YWb7biSUZ0dYOmJKOX+Bd2FQtcDBFvmzmwTBA3DBD3eIVMa0f241JjLZsXQDvdp63kAxmfwVyskwkYWqKzwhCewYdyiLeh9DLFHNfHiRUixyFW6OHYlLFCJP3eDqUqobz4pFthkm2+bzcwiuUNh45HkGBRTHSBdmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=H9AfIao9u2v7tBzmAv5muhNQLsvy2BvtB83a64T8k1s=;
 b=xPBaZqZOMG/qX4CrRkJINKYVQfVv51qo+k+brMjc0n7rlKJ1W/z8+uJNoE/kgvwcL6CieXzK401Ay3VtSOo7U8v1j0AAH41FZnpdTvqt1jgBjM7XDlTv73VC5h0VyrppQv7Dd5RL6ZUMgXrCwomNEsq1QFiKqYo9MfX9rqN/S/e2cliCXZgBKkfAdPSaQIC2uK3rzEedAhV5V0/7jof11ZG5jHkfFuHiy9oDRZ8J/4iX50H/4eO+CaEGYVP/5D2U+bRaBtLZhEDcZ+sy8Hdzoj/AzKISXJ8oMQsePr9Ui2Fdc0CYO2F0Dn7Toqt7Ns36Zb9p/hF6Ay+yLWMVUh+Bqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=appgate.com; dmarc=pass action=none header.from=appgate.com;
 dkim=pass header.d=appgate.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=appgate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9AfIao9u2v7tBzmAv5muhNQLsvy2BvtB83a64T8k1s=;
 b=V6cIfd3HGzj+m9XCxTFdseLm+wbjdZJViZatpqCWAFeJfujI1WzlanSnJ6SPdEeQ92e2NBN5DgoKBvkvvWIoMniWMnMElc8wgYilLX2F/PUiBMMravULnf6Bb4jlr8vPQokqNhR5l2WnC4u4g/dbU7vwXosPvwzY1wjPKsmeQM0=
Received: from DS7PR05MB7320.namprd05.prod.outlook.com (2603:10b6:5:2c5::22)
 by SABPR05MB999253.namprd05.prod.outlook.com (2603:10b6:806:568::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 06:02:17 +0000
Received: from DS7PR05MB7320.namprd05.prod.outlook.com
 ([fe80::90e8:a175:4ca1:74ec]) by DS7PR05MB7320.namprd05.prod.outlook.com
 ([fe80::90e8:a175:4ca1:74ec%4]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 06:02:17 +0000
From: Dave Butler <david.butler@appgate.com>
To: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>,
	"anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@kernel.org" <edumazet@kernel.org>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"emil.s.tantilov@intel.com" <emil.s.tantilov@intel.com>,
	"luoxuanqiang@kylinos.cn" <luoxuanqiang@kylinos.cn>,
	"bryan.fraschetti@canonical.com" <bryan.fraschetti@canonical.com>,
	"tristan@talencesecurity.com" <tristan@talencesecurity.com>,
	"tomasz.lichwala@linux.intel.com" <tomasz.lichwala@linux.intel.com>,
	"horms@kernel.org" <horms@kernel.org>, "aleksander.lobakin@intel.com"
	<aleksander.lobakin@intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "jacob.e.keller@intel.com"
	<jacob.e.keller@intel.com>, "aleksandr.loktionov@intel.com"
	<aleksandr.loktionov@intel.com>
Subject: Re: [PATCH net 6/6] iavf: cap advertised max_pkt_size at the
 single-buffer HW limit
Thread-Topic: [PATCH net 6/6] iavf: cap advertised max_pkt_size at the
 single-buffer HW limit
Thread-Index: AQHdT53CBEJx2voabEC4EKwJRzbAtLbmTmkAgAA/zxg=
Date: Wed, 30 Sep 2026 06:02:17 +0000
Message-ID:
 <DS7PR05MB73208F63C4605A1D0CBA79268B8B2@DS7PR05MB7320.namprd05.prod.outlook.com>
References: <20260928230429.495442-7-anthony.l.nguyen@intel.com>
 <179072991678.434549.17815320009417499641@kernel.org>
In-Reply-To: <179072991678.434549.17815320009417499641@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=appgate.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR05MB7320:EE_|SABPR05MB999253:EE_
x-ms-office365-filtering-correlation-id: 206e13d5-b4d7-4af1-f76d-08df1eb861e6
x-appgate-rule-whitelistdomains: triggered
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|4143699003|10067099003|56012099006|6133799003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 8ySdOsUDmfbztlyr59bAPjWeeVJ8ZhABYCTdxRXBzRsIj06bgVk9BKSiICy717nmtgErKwdZ5eCt1+x+gXJ5Qiz4izB7NQM2e7U9CvfxJJ/wN/iPcqftHTdgLLJD9tCaXWOS8BxiVTmfVHiasAnq5JDVO5EL2QKXQjtYlce3qSSPQsgl4FUMsEAa5rtCczKTiiU0YL98mpjVTfcROgPfmDdPJJIhJyp8dxH4NH4S2YbffxmBhPu06qvs5bDejJ7+/IIVhC6ANU4hc5xBQw/ysa5GXrYnBTCvdS52ZhrenY/qBVTNq7wAA+kV3wg/URUboKhn/CisCJmWAv7IjdssSE1VMy5glvAkCnBJg8IDCTBXag4AORQFsdHxUQkDPeeAVzXDPE+oW6Xy/PG9k2tlNNzyDs1rUOW/eygtURCKVkmv8OzqLKUajzBcZWnmbN4Fyvn/BJgKjh4F65ULpTF37m+3+opx5iiXGaLYeqhYZaPNXbh1xOmhKvRBnlghuBAiiGvdtYcTGqNXWHRBrUwcrJf44Way7gEs8F49yWnBe49aZqt+Atw118CZCE4o2kcsV7E84dxiGtv4lR1VHDkXWL0CWcHlzr13biAa/d8l562gpDGsEbyF4cA/2Q39Ymkz0H58jaQuGhqjySSp5A759kgguZvzjl8rt+Mg+lm6IHICLNv0LLPwmmCJLui6bn9AaSDld/kiCzmE8toD6ePZg4ofwPCLQGrIjw4CsQRB+aw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR05MB7320.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(4143699003)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?koi8-r?Q?El/mLeqlQasMMsOXlAGodS51mXb5xyGRIpC/n/rjQ+OxYJxsv4LReuDn/qYV9T?=
 =?koi8-r?Q?V4yQEn45EtUz7qG2tEw8QwRZTM2dRuaBLVhRZuhWlyRee0dH2UhyxqY1buffQC?=
 =?koi8-r?Q?wqJ4DbCuOVGonK4qEQ9vkripYs8EuXAoygZoSQfhXG8HaSEqRlwKB4hpcfaD9S?=
 =?koi8-r?Q?EbdwEJw18Vw3Dl37mk6mMaDshFqNexUAmdVVc4nvdSTUqVBkE6D9m26AFR62dJ?=
 =?koi8-r?Q?zAfbBcqmwpTP85BEa0mjXfqHwjpjmmQolIBqpIOmNH2aomOEIOafOpuQL3YbJ5?=
 =?koi8-r?Q?tDcgcbTQS58jWV5gcUYJR358Km1Db123iZa3skU4R3kBy57wiCOrsV9Hq/o/JW?=
 =?koi8-r?Q?Zzmx3yXkd/PC8wsSt5yfoGVQntHB34xxPsxROfa4K+FnMH2AMBHkSYgK1lwInT?=
 =?koi8-r?Q?bTDZSJQnDKIU2xeKqZn/xQNO6PeWPDB0aoNSf2O+mJIBR0muH1sBlWdHSO9IrF?=
 =?koi8-r?Q?Lgors3xMaiDs0z4NQRab0n+bCpARFAKchVHVGvBMLdAR9WHUyyPdIXbPaGat3d?=
 =?koi8-r?Q?0agWYXkOBWbTzrJowYQiGLFOFMTpLDJZB+HyFSnHtmXSb8BJkqWjDZzOUal7VD?=
 =?koi8-r?Q?yM4PiGuhnEsUTflJ5MOGwB6AaxEV+3FtN9mrjm2LUMXJQc3zW47ndPQC94UnaM?=
 =?koi8-r?Q?m00Npk+wl96JBEuPVAbx3jFT159eAejo8iPHfTbMlSZWOJmPBxEDCHHQ6d5lr2?=
 =?koi8-r?Q?dGDQ7lIKcauofN4UR0law1AnlxTbyUlkPkX3NofXaXm6ZUk0dU2UCSXtaHaoIM?=
 =?koi8-r?Q?aEG+Io8oYPKdJ0xqxBTNfcKmsBmoU6cztzU/uPoVjDyopFK/jcIr0qHHfU8j3m?=
 =?koi8-r?Q?uMeTZ0k72iptoRW2tmcY5gvdCS5zB7Qx9GmHU7+/+wCzDmVrT3yLHcSTCEhLjU?=
 =?koi8-r?Q?94hJdNWBjU0lwCZbW8dUMatxqW9xnxblJ70LC3nqikKwODCqyeKVNwON7LgQD+?=
 =?koi8-r?Q?/g9cVtCKCxXk6JIuBFPV+qGs2waqAfcOOSCAgtdhT+U44xKol/mZdcAtYGCKH+?=
 =?koi8-r?Q?sfN9tnKQxRb5fu4zI9TmGvUZavqdldsXih/ULJFMQEuHo4PRKOq8wxOOxHByXI?=
 =?koi8-r?Q?huF3Bg2XHjUsRQcK2YKL9nUW10UbO6ynX2WWUYOzM0UjbKMkim0g1PAGJ+RSDg?=
 =?koi8-r?Q?zLI9r9PGr9ng7LQu0mz/wOAbSBn/yF7cX7Ocvu9MrGqlreezd0cbf7J7GdvDPH?=
 =?koi8-r?Q?w93uDiS/qHDzT2BZiHthDDIfaxRP3TMVLFTh8jJNdrjlcaWwjnvAaUhV2Kcj2i?=
 =?koi8-r?Q?+ZiCdh1hMeEIbPwufSAXbw5HzYONke7jAcBWZE3G7yR2Q7WdH7Rg3cEakL2oEa?=
 =?koi8-r?Q?25rxwV+oGt4KQKPxEIVoiYCULLK5/SxJoTqg/e9QEcDeFvE8lUkctxlrlW0uGU?=
 =?koi8-r?Q?rH+U1HqWKxDD0xjdj6yPxn99oErVHRO5xcpsYsnx0XjYOKP5v9MXnX1LAqCVW3?=
 =?koi8-r?Q?wuV1/GsN4pKknXWi0Qdjz1a1hhx+em5SBNHR+pp0oPh6pyM0WtUd1sq+B4iVhF?=
 =?koi8-r?Q?ku1yq1qFL+GetaTxspqM1h3Ghd/YvsWCViwPkqngr8kHqdeBilRoefHcWjpmQF?=
 =?koi8-r?Q?+/hnwRvc5KKmMlaUA5QnL308V5gM6lCDp04zDJ+Ds/kz+3Bn73H6MZ3Uo86Fwt?=
 =?koi8-r?Q?gpCNgzcZ2zODRHid2g1ufmMRyQkjezritAx6bUCNrFe5sdu621PQ6zgniZihkH?=
 =?koi8-r?Q?4LVvu0/qBH3YZQ=3D=3D?=
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: appgate.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR05MB7320.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 206e13d5-b4d7-4af1-f76d-08df1eb861e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 06:02:17.4777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b93e809a-49c5-4a0f-a606-82b846acc30d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hHQJnV3WoHVqGLuaPLozK8ZmRbCh4wx7CV71OCE19KSLNd5jijLpObPikucLyp+qDE7FD2mJpey3HOiNa05ZNPQTco5VKWJoZsVWFEeOPIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SABPR05MB999253

> [Severity: Medium]
> Should netdev->max_mtu be clamped to match?

Yes, the review feedback is valid.  The bug outlined by the review is where=
 the user sets an MTU in the 9728 to ~16356 range and frames above 9728 are=
 silently dropped instead of the MTU set failing.

We should still move forward with this patch but reword the commit message.=
  It will likely be at least several weeks before I will be able to acquire=
 and setup a lab environment for reproduction and testing for a new patch r=
evision.  This patch as-is does not introduce any code regressions.  In eve=
ry case the behavior is unchanged or strictly better.  Practically speaking=
, most users would not be impacted by the frame drop.  Standard jumbo (=989=
728, e.g. 9000) is entirely unaffected.

Since 5fa4caff59f2, E810 + ESXi icen + SR-IOV has been unusable: the VF nev=
er finishes CONFIG_VSI_QUEUES, regardless of MTU.  The effects are not cont=
ained to the guest that triggers it. Under pass-through the mis-programmed =
queue can raise an IOMMU fault that wedges the PF/VF on the ESXi host.  Thi=
s usually takes out that interface for subsequent guests too (even if they =
have this patch).  Recovery requires a host reboot.

A follow-up to adopt the reviewer's fix is warranted.  I can provide the pa=
tch if someone else thinks they can test it sooner than I can.

A revised commit message follows:

iavf: cap advertised max_pkt_size at the single-buffer HW limit

Since commit 5fa4caff59f2 ("iavf: switch to Page Pool")
iavf_configure_queues() advertises max_pkt_size to the PF as:

        max_frame =3D LIBIE_MAX_RX_FRM_LEN(adapter->rx_rings->pp->p.offset)=
;
        max_frame =3D min_not_zero(adapter->vf_res->max_mtu, max_frame);

LIBIE_MAX_RX_FRM_LEN (16382) is the multi-descriptor scatter/gather frame
ceiling, not a single-queue value, and it exceeds the E810 MAC frame size
maximum of 9728. Per the E810 datasheet (613875-009 section 13.2.2.17.1)
the Tx frame-size register PRTDCB_TDPUC.MAX_TXFRAME has a maximum of
0x2600 (9728); larger frames are discarded. The in-tree ice driver encodes
the same value as ICE_AQ_SET_MAC_FRAME_SIZE_MAX (=3D=3D LIBIE_MAX_RX_BUF_LE=
N =3D=3D
9728), and the VF clamped max_frame to IAVF_MAX_RXBUFFER (9728) before this
commit.

When the PF advertises vf_res->max_mtu as 0, min_not_zero() leaves
max_frame at 16382. The Linux ice PF advertises max_mtu =3D port MAC frame
size (<=3D 9728), so a VF behind ice never sends more than that. The ESXi
"icen" PF on E810 advertises max_mtu as 0, so the VF sends
max_pkt_size =3D 16382, which icen rejects while programming the queue
context for VIRTCHNL_OP_CONFIG_VSI_QUEUES (opcode 6):

        icen_ConfigureTxQueue: VSI 8: Failed to set LAN Tx queue context fo=
r
                               absolute Tx queue 64, Error: ICE_ERR_PARAM
        indrv_SendMsgToVf: VF 0: Failed opcode 6, Error -5

        iavf 0000:03:00.0: PF returned error -5 (IAVF_ERR_PARAM) to our req=
uest 6
        iavf 0000:03:00.0 ethX: NETDEV WATCHDOG: transmit queue N timed out

The VF's queues never come up; under SR-IOV passthrough the mis-programmed
queue can also trigger a fatal IOMMU fault in the guest. Forcing only
max_pkt_size back to 9728 (and leaving the Page Pool rx_buf_len/
databuffer_size untouched) makes the VF come up; databuffer_size is not
involved. This was confirmed on two E810 NVM versions (3.00 and 4.51) under
icen, so the trigger is the icen PF, not the firmware revision. Reported by
several users on E810 + ESXi icen with v6.10+ guests:

Link: https://community.intel.com/t5/Ethernet-Products/E810-C-iavf-driver-i=
ssue-on-Linux-6-12/m-p/1737490
Link: https://access.redhat.com/solutions/6973766
Link: https://knowledge.broadcom.com/external/article/404315/sriov-enabled-=
vms-network-adaptor-goes-d.html

Cap max_frame at the single-buffer HW limit (LIBIE_MAX_RX_BUF_LEN, 9728) so
the VF advertises a max_pkt_size the PF can program into the Rx queue
context. This is the value the VF used before 5fa4caff59f2 (IAVF_MAX_RXBUFF=
ER).

Note this only caps the advertised max_pkt_size. 5fa4caff59f2 also raised
netdev->max_mtu to LIBIE_MAX_MTU (derived from the same 16382 ceiling); whe=
n
the PF advertises max_mtu =3D=3D 0 that leaves max_mtu above 9728, so an MT=
U in
the 9728 < mtu <=3D LIBIE_MAX_MTU range can still be set while frames above
9728 are dropped by the queue context. Clamping netdev->max_mtu to match is
left to a follow-up.

Fixes: 5fa4caff59f2 ("iavf: switch to Page Pool")
Signed-off-by: Dave Butler <david.butler@appgate.com>
Cc: stable@vger.kernel.org # v6.10+
.....
The information contained in this electronic mail is confidential informati=
on intended only for the use of the individual(s) or entity(s) named. If th=
e reader of the message is not the addressee (or authorized to receive for =
the addressee), you are hereby notified that any dissemination, distributio=
n or copying of this communication is strictly prohibited. If you have rece=
ived this communication in error, please immediately notify the sender by r=
eply e-mail and/or by telephone and destroy the original message.
