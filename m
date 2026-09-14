Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013000.outbound.protection.outlook.com [52.101.83.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315553D9029;
	Mon, 14 Sep 2026 13:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789394164; cv=fail; b=AeQEF6DRcyEBrTOXJ8UH44vOVFuWWDbl21p2uthHYSzkqJ6Hyc5nve4hzlMIRX5Quac638f4vC7pWfpI+qsG9HLXbSezNwKPwJhLIPCjyiwnW4yo/BpBASwznTK34bk9+zsVArQmyX8i84/f3tHZYPMNzYZsDs1d6dWWtvnqrCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789394164; c=relaxed/simple;
	bh=xkeYCtWz6xtkzC4M9AWreXBpHgJJm5xu3ajleC4y19A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BY71ZsZKz0k0vt0NkzrHa+JdgqkcQTR9VAx1EgMXlcJojrnKhEqRHHxGukTZh/jUFwzR5vPwn97ZNnC/AHXvVSRemqIkJUkUOXLZvEVJ+xbGulzkan4CVgvkj9H2/vb4GSvO1e0aOb6GLKr/hcl+NDrUlCrW8FNG6T5Pn0MCIXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=g7saD8Sm; arc=fail smtp.client-ip=52.101.83.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="g7saD8Sm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JQcboAr+bLJNz1DWh0LTohKVaD0JP9hytywMoHOOJzQmgVfHSrmHbEKxF3InPOuupqRyJ4HVw5PDGgWuPbf3gS3NaowbJ7dGCQKnMbmwZWbfYygyAz/9HAw3Vf0nrh7qQJzFIlgXo3KO0ssMCiKPiMU9YFOcsbC4wa+TGvZ5996wd+yYOf/2oT0zx+wb2rZs/eISII+mmdA6HaDFNQgQpeI0aUmKdWa33hjSzzVarSEffaz+4L9TfTHsCduca2Xl5kltIQD/3ywS6+DYIThLpcEUHny/3E4V8cPM2roFIsLIQ2Rh7Vpvjh32s2l9npkr5eXGz5BW4/JiDOJYBrSUSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCX7QhfC5sqXYjNMsiL2TGAG7/QLmXifJVxhVgsG4yg=;
 b=dQfXsAG7nIG0wZuF7yVuHGpXQagAKX3oxTxP9RCoMKipQ4HdTh7nsLCqNxykaVLjfo1vbvk4LANnQDFfty2EGifxxzTSm8JlKZOu66U0qHkLaI49p2a7pdalk0fwJgR0jzVNlQUEpe/PctiwfD+jdLEA91r7s35ddejiDd2D7E5cxeFMMAlRCsBGLH+mTRkOUQMGaW6EkFitdRAKpiaWokvYKMpF1z/fiXpays3xCCrSIDB7+lbl0DTLEl3/Ez6yiqYdJdmIbIwE2elLl6RHWEgo512DHEqYp2ulDNPN4RJhxOm2pGfAIJu0QFlfvpEKxwH7lVH8qSJhi7PlXma81A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCX7QhfC5sqXYjNMsiL2TGAG7/QLmXifJVxhVgsG4yg=;
 b=g7saD8SmxjSIp0uF9lF8n3fFZdgjd4DiT5fInjN1PUiUE6QyqjAZ2W0h0zcr7Ewom1KUVnbonU1WKK3W6u4vryNwCZp8v4eNyAxM7wvPdSw9DjTo0/0hTucOiCOIpegBpNtUVY4D2rceGb8AyB0I2qEtk01YIWbO5pKjzmFtZ8ypgJ3j5LW1R1+8V0LpzuoP9j89YA7Bslk+H+JMeyRHFsFnmwvXFL7KlBaoK81wAS1NbMq5gISQ5NOMDRx59H0had+TMjmJDT70GPjb0LqX0r5Iu0Ms0IzrE9mosFyrCNJGUDDhud7VrlKsl6vF+EKBMe8RCRQJpvG0LPM01PHQZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU0PR04MB9634.eurprd04.prod.outlook.com (2603:10a6:10:31c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 13:55:56 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 13:55:56 +0000
Date: Mon, 14 Sep 2026 08:55:43 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>,
	Todor Tomov <todor.too@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Bryan O'Donoghue <bod@kernel.org>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Felipe Balbi <balbi@ti.com>, linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	linux-phy@lists.infradead.org,
	Krzysztof Kozlowski <krzk@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v16 1/5] phy: core: Fix use-after-free in phy_get paths
Message-ID: <aqf835LdzdNZR8rh@SMW015318>
References: <20260906-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v16-0-f7bd68b5369f@linaro.org>
 <20260906-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v16-1-f7bd68b5369f@linaro.org>
 <aqRq-xZRIDL1apdI@lizhi-Precision-Tower-5810>
 <44634913-fd6c-454d-a3a2-6a8d541b2c1e@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44634913-fd6c-454d-a3a2-6a8d541b2c1e@linaro.org>
X-ClientProxiedBy: PH7P223CA0008.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:338::6) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU0PR04MB9634:EE_
X-MS-Office365-Filtering-Correlation-Id: aa3d1cd3-a6ef-4643-51a4-08df1267e629
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|7416014|23010399003|1800799024|10067099003|4143699003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	oCcEsB2Ex93kxj6U/Uur5Q656B+qW9U6tOzhrzmFlzvBxgv/zVl2VM7Dg6dmRAZTPan1kix6ekrNRr4NEdWhI9X4rCpBBvd5PksFX+1rjIn8z02raScU6GmrAH3y7apvPPKMqb1KATvdAQwt+cjHenx/UkLIVjdYCLqf3WWQKs2mpHJqP6mu2MC5nD3Jj0Nl/aL22ryXtyHYgdcZR61XeLsm6vU8BjmoR2WpkrvSFtXKjPc8jOLBdM2w9bhCbUk5DpasJEGdhIMZzYaKg6EmI6MBSVjVumDes46gsRJAZpDYXRQQYANj2fjx2NOEK/M+hgPdz7JlQHJMJIxJvM+XgvZPsQ9KmKKXSnnwfWaG5xRb0/GuX5yQgiHgyJz/jQJZaZ5Jnq1M8A4tegNasWwl2kl/YjmeNP00ax3ynBl1id96Uxud6TBK9wJ3eHnUEZhiEArkH+zxndAxM+6gvdi/5zX4zT40zvaeoOMPXyQAMal93YpxTp7NuZzmkFr8J4vlfCcCT38lpil1iWcOsZzKcxQFG/XAWib9aUT9DjezrJ1SwyVHH6TwL9i57+1fnNVx8GnbR1vfaNL/DTCnMW2n0KqcKG1dRzkgUOb5+UVOfZiSuPfOh5cRnNsjJrRQDi0EFzXJo9VOlToWLAuAreerRXh2CTxedVNSR2u0aUi7cjc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(7416014)(23010399003)(1800799024)(10067099003)(4143699003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b11huIWGVDxCZMvoiM3+T6R9Z4yqYbRiIvknUWJz+btYIBGE7qbt6SzKxVmi?=
 =?us-ascii?Q?8i7Aeu0f7twj1WeCJL4bzAqf0/PT39o478e1sosRTVcdbnKV3EGfBCtgNI4o?=
 =?us-ascii?Q?lSus6jfBZ/ExXcD2B5IkibJCGffTaY453J/y3Ua4z5a3KvtMuIvWJiqyWh6q?=
 =?us-ascii?Q?YeLRztPkf3QpHkCXhf68Twjm4BE6K0UOiEUz+3ZSAg3Qk3ZCN2ZZQxH+FVZp?=
 =?us-ascii?Q?E1g2ifY5EBsXd/qsXwZuzTYE2vBwRWgfjwNxgS/mutAnw4et0FpoFCPo+REA?=
 =?us-ascii?Q?e41uiq1oavJgbNQ27NJyx95lvql3t1OJSccUNKpfCvr2pXjEBOYZ0cb2A/bW?=
 =?us-ascii?Q?ee//zOE9A6eT6lZk4J1cmwo7O2qidyvgMCYh0jq4oofBuwtRvN4xs1x1NlVW?=
 =?us-ascii?Q?XcvIAj8qOWq0GqgBY8MinvqIWcXJvL4JKxLx6dCE7U5QPhcHfBJiIYXHbhjM?=
 =?us-ascii?Q?MdwKzVKulvDeuivwkrEq93Fl7ae7KKdVvRS5vIP4PgpjYY5We8SsAUXeCuFK?=
 =?us-ascii?Q?f6g74zfVOp952I8fVqrOrM4Crkfi2SS0BppgzOmEfTKC2A11vlqQ24Qu3u3c?=
 =?us-ascii?Q?bLq0k2Enqn9bLeAAc+jilA+K/RdxXRLZcj/BWd0lc8Ra3k4W2XaanaIeSMke?=
 =?us-ascii?Q?854UEAVRPX4jsb1WoN4u17T/nEErWbOa67KUJXy2mMlFwqePHt19znT8m8rV?=
 =?us-ascii?Q?ugEOjDClrEfPp+bC6qnWuEkiRCMDy/FjLUfx7TK7Qa5JxLVfcj6aRgnzd0ib?=
 =?us-ascii?Q?CF05+VTDLApADVz/7t++hfLWoH61xGZJUoO9CWGzVUArdS369zyO/ZFEAIjI?=
 =?us-ascii?Q?nG7p7xkR8mTik7ovDGkEpgTu7wlk/1fYpIdzgM3Cy2+d7IThmdK+pX0hxg5Y?=
 =?us-ascii?Q?h2OQxaIkVb+PDGPOhHAoZWda8M7qxbNEQvfL5l7FjdF6VQTB9f+uJ5Ztc+iK?=
 =?us-ascii?Q?rVIWUfz7jkEi/ZCOOkNExut5kJkmeoWbochi6aPAkyDlVvLlUvVbilsqPbMT?=
 =?us-ascii?Q?t+7+zYNT/y235ilxG1vD67SkFH5xF/r9yQqJcX7fbYtvbnfuXvCpEUptIPML?=
 =?us-ascii?Q?x27Y4StXiDltoQscNVLnDXBeWKsKM6KspEWZd8Bd/gYnjDczyeJ651vDmoM0?=
 =?us-ascii?Q?WQ55zQDGIiUqr3eBLvji6IW/mlH5i7Q2aMorEATddhkhiVX3VkGjuAKe/E34?=
 =?us-ascii?Q?x8WfjZeoubvgpGcbgWybbn9KsC+UJ8nLqP7QT52ADNK1HgDJoYKeKp1kHn99?=
 =?us-ascii?Q?vBWeuWlvass83EgbVJ2zFJ31ka6uPGo3IX1aqBavT8k9y4L0HNZzReJJs3v6?=
 =?us-ascii?Q?kfRyJAnUWxyvBRxIVLoQjAXehqHQsoYgvmKpjA2ZSTKjwByL03QAKtwu+Xqj?=
 =?us-ascii?Q?cb942P6qL4rTy/smjMFP4+BltzavT0xBpY5y1WlstAQCW26V+hAhd4IJhNBa?=
 =?us-ascii?Q?2or+x43opsigpSmqkq6hfBSYHhhyLIzmJCWYHU27ptGRQLSYRmbY8LILZdpu?=
 =?us-ascii?Q?jjO9JOuFLJYal/1DL6N7b5H3+UtU5QWjeWaXuVEt6eIwzjOvUzYPCZzmEE+t?=
 =?us-ascii?Q?qbSBzYhkh1uztduUSryNPLPrcSkTv9SZ8pMV9mXgEBQAhKZ4F/fMGiaMot9p?=
 =?us-ascii?Q?aH0so0bp91z7vcpMJe1nyZGqZSe/W5LQH0c+nZVASxDazmEL357v6dQF8Oe0?=
 =?us-ascii?Q?WXBZlYSvJAD50zwhDMqyO0LcMAM+OSHiZyEqILPpV03nE+odGEapXOu4E4tz?=
 =?us-ascii?Q?RCaEjYeIT07BW2PtKqa7BSqXNQEAX0IkVhRO+j46brX06WecScKx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa3d1cd3-a6ef-4643-51a4-08df1267e629
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 13:55:56.5104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1e/hqwwRLfjBzIwRhn29HjiCv+2ivlZVnqZkYbgioUDnAQlfqCTJA5XJI72zJm9XiH+TTQBfuCeckibsuI9X8OI/qxt3QfwlNtSTtRNXRKVi6q4iIKepdlcY+lxQADJ6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9634

On Mon, Sep 14, 2026 at 12:37:06PM +0100, Bryan O'Donoghue wrote:
> On 11/09/2026 21:56, Frank Li wrote:
> > suggested subject:
> >
> > phy: core: use phy_provider_mutex protect between _of_phy_get and try_module_get()
>
> A pattern I try to encourage and role-model is making fixes very explicit
> and obvious - frequently I'll ask people to prefix their patches fixing
> things with Fix.

Generally, I got feedback from most maintainer is

	do something to fix ...

"do something" become more important. the most maintaniner dont like simple
said
	- fix build warning
	- simplify code
	- fix UAF
	- fix memory leask

I think it is reasonable, git log --oneline ..., if just list
	"fix build warning", which is hard to locate patch because there
are too much "fix build warning".

>
> I'll split the difference with you since now that I read this submitted
> patch title you're right, it could read better.
>
> "Fix race-condition between _of_phy_get and try_module_get()"

I think it is fine.

> > > Sashiko asked during a patch review if the existing usage pattern had a
> > > race condition; specifically in of_phy_get() if it was possible between
> > > returning from _of_phy_get() and running try_module_get() that a module
> > > might be unbound leading to use-after-free.
> > >
> > > Looking at the code this appears to be so, there is no linkage between the
> > > phy and module under a synchronisation primitive.
> > >
> > > Using the phy_provider_mutex in phy_get() will ensure there is a link between
> > > the returned phy pointer and the module_get() bumping the module reference
> > > count.
> > >
> > > Amend phy_get(), of_phy_get() and devm_of_phy_get_by_index() to fix the
> > > same usage pattern.
> > >
> > > phy_provider_unregister() must take the phy_provider_mutex so amending
> > > phy_get()/of_phy_get() to take that same mutex guarantees there is no
> > > use-after-free.
> > >
> > > Fixes: ff764963479a1 ("drivers: phy: add generic PHY framework")
> > > Cc:stable@vger.kernel.org
> > > Reviewed-by: Loic Poulain<loic.poulain@oss.qualcomm.com>
> > > Signed-off-by: Bryan O'Donoghue<bryan.odonoghue@linaro.org>
> > > ---
> > ...
> > > @@ -678,15 +677,21 @@ struct phy *of_phy_get(struct device_node *np, const char *con_id)
> > >   	if (con_id)
> > >   		index = of_property_match_string(np, "phy-names", con_id);
> > >
> > > +	mutex_lock(&phy_provider_mutex);
> > > +
> > >   	phy = _of_phy_get(np, index);
> > >   	if (IS_ERR(phy))
> > > -		return phy;
> > > +		goto out_unlock;
> > >
> > > -	if (!try_module_get(phy->ops->owner))
> > > -		return ERR_PTR(-EPROBE_DEFER);
> > > +	if (!try_module_get(phy->ops->owner)) {
> > > +		phy = ERR_PTR(-EPROBE_DEFER);
> > > +		goto out_unlock;
> > > +	}
> > why no use auto cleanup guard() for mutex lock?
>
> Technically this fix would apply to kernels predating scoped_guard() -
> kernel 6.5 v Fixes: @ ~ 3.13.

DMA engine already use cleanup. consider the same maintainer, I think it
should be fine

Frank

>
> Not really sure how far back the cherry-pick will work but I'd like to give
> the possibility.
>
> We can always sweep this file to use scoped_guard() on tip-of-tree later.
>
> ---
> bod
