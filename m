Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013042.outbound.protection.outlook.com [40.107.162.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C72B394EB7;
	Wed,  5 Aug 2026 19:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785959606; cv=fail; b=PnCcfDowhYml+5yoqjk1ldua8zPA5uemeGPJRFsOMsjOzfozh/Amdc9buiya6UR+JhkvNl9BARfYVA7rP2Mnt9aMrlzJ9/5fDjSo4UA3pNc53rOZzLzDLpr5qnSEe8r5QCms3xQJK+4jRWz9JHCJyEFZ8gdYjoFhrkdzrqIP6kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785959606; c=relaxed/simple;
	bh=4A8mJhfY48/4BPW+QftfFDw4wIbWtZdcVHhXgUks124=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V5LVDcJwFJaFtj7nZZQuqtLvvIGNGv5it31M/RTBrPoBnewRGkkoJXJN9yGCZbxcQtMQaM3FF6fYui4o5ZFDJHEvc+okxan8EiGRdHrcn/dzIKE9WdFMgIA/ZzXM7vvLV+9U/Ncsy5KC+fGaVn2pfIpG8d7yTSofCuo47tpZk34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=eCzGrUjN reason="signature verification failed"; arc=fail smtp.client-ip=40.107.162.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="eCzGrUjN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fd6aA9zY74kpzXOHioMnQommNmTdAhED0AmUSbecfGCcnPO4lkUhfikY2T8YTl8UkU0kKJbMcd1r+IuRBMPwjEDW01XVNwv+tXszVRgJtR9gOxxlagqe+Uo0ZcQXiajbJJhZOHm6/Uur/IjVwgCqu4Ol+P0I44GUa8VoFNBvCv2OfBQL3JfUJewVmVwuxBC5Jxt+ezLCsr+3LjriCYctgtghMrrP2jjeiIi52E3/zP+qbamYBYB8lPTq83PXZizPIKpT58/wVK2zqkPKDT5G8JkgZMoWbl7nKrTzjtTe6KDT/kUH5EyZuVxTAt4SdkxUa9ikd7Zhx3InYpfGd4tDxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1ii/5jpfRlvyiGkSLJXz7lAUelWrnxAPzyWmiD+xvE=;
 b=bVrW5k25SPYh7KPeEd6wW7Fs8rDcaTvrY7h+L/4BgUQ26zXJUU+dke8yNGqroXH7lnFg4U0QeyR1sLDxSgyIPtjY7VPHRNyHSO7AWtsE5R72kT0mNr7Lge07xOEdMtXe03R0sEefwfUijfVmIam4djmfQJX870rACDG+czTF0CkcJW0IAglDunaDugCmvqn4hz9PrAREj7VQs9TPw/P1N6bPMku3S2VjoCq+3OKQKj2G4tmR3kB+YN4V8UjOHiOOGfH6+UPNNfKANkwuUW7KlIi9Mbf6gdx9D5ZGfNWvKG2Wa9LfAU5BNz4feZFRLUzWDJmSXGYxSEv+T0LaXTVXTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1ii/5jpfRlvyiGkSLJXz7lAUelWrnxAPzyWmiD+xvE=;
 b=eCzGrUjN4ijNjQpkAig1Ah4FptdLCzHvZbzVAqfz6NTwY4QF1rXJW6OOy2TukuZ+QumE8F8PCczGxh71A5xuTGRTzZMZYtWO+WXl0V6qBQ/GulzeMQ/2XEIvYCHRydE7q75y0qSS1EcbAwC247rwWtPg7h6852/4if4XUVftiB5Jky2XvSbbvtWJP3nk7UDWzeae17mojK2XTElD4vhjIATU6dFNPpbwDGJ+uaeCclZdhsk+ss4hXHtzX4LrYZLU6q6zC6VzMgQRZ0jNoKlOMa9dkc39yIO6lkQj13UezNF95iGw9P9mfIN2N6urehaQn9cDd2wVoufvLaaSSdHXlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV1PR04MB9149.eurprd04.prod.outlook.com (2603:10a6:150:24::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 19:53:19 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 19:53:19 +0000
Date: Wed, 5 Aug 2026 15:53:12 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Akhil R <akhilrajeev@nvidia.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Frank Li <Frank.Li@nxp.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	Sashiko AI review <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 4/5] i3c: dw: Do not use OF match data as a quirk bitmask
Message-ID: <anOUqKmzMVwy1mpz@lizhi-Precision-Tower-5810>
References: <20260804101301.2975911-1-akhilrajeev@nvidia.com>
 <20260804101301.2975911-5-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260804101301.2975911-5-akhilrajeev@nvidia.com>
X-ClientProxiedBy: SA9P223CA0024.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::29) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV1PR04MB9149:EE_
X-MS-Office365-Filtering-Correlation-Id: 127cf09e-a7fe-4d36-7974-08def32b327e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|19092799006|22082099003|18002099003|11063799006|56012099006|4143699003|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info:
	Q9QRkBsY44PtqOFpPNOiUzWWRIhtPcpFw0Wg6+ksL4lhS1gtwxBif35pGbQQLn2Pv9yRSZtaIS/1e/lF8omBt5tj3TWKtdGfD1rS1spFfPpFNdOGjivjW7gh6xHxBqZ2AaKKJXvuXlMGRVpuvQH0KKBE/39AF9xa91+4G3owa/N7Yz8cChNMjTt3ROwnyhcz3Ksh2jSUZoRzji7WZSt8HzDWkrM37EdexFKgMkR46A57uxVjvC3HNrE/r7jGVkLt08R1Rf/mLgCa+Ec/PNwRZlKxIpM68Of6/t6zjwuQ/fAaz7+AffR/kIRTy8G7X98E6H95N1fanl/YQvA+LxElBHn4f6KCCvkuEKu7xZkEUDKzbEy4CdXHtv3tqowknxwyZPMYOUXyT8Rgb2uzsUbLScK6Xsm4rUq1KI9QaLQpBUrce4/iPaZtUoehxUKjz9nXgjJE9PEgEK8eAxWTdrinClSwTmbrqWdlNVrJYpfqLXyY4iSG8ZSO+0f+8AsvpPtRoIM/C3yZOEllTaQIBz3di0qBxyMTK+Fjv1sOgj6TouZSe8IJ5/VY2MQoxwaIi4qX4Y4Mwf+zLZRZ4FZS/0yZnFX9z47CPT5CMS5BgJ7uHJq0X3N8vu4w7VW0pp2LQ7ZZ9AKGPBYzjF97bxqr9P6YcKoZoZZ/mm3pzI+8cYVVowk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(19092799006)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003)(3023799007)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?oebywRT81qBlvKIPcr383uSW/pYx5HWW130OXZZmfX6YwaaPvdioqV3j0v?=
 =?iso-8859-1?Q?gEmCLTxJ5dcXYpyEyhgW+9l7kRr4GltbbppgxDoj5Vt9+HgcYZhn3C9MKA?=
 =?iso-8859-1?Q?xXI2KPDgeB09S26T4K7ZbKD3Nux7Mt8xvk6NHPP25xWRYN4HWXixOijJCg?=
 =?iso-8859-1?Q?HUBC1VqlpQ47NbS4jHuFMlAjfGF1MSO8HkLcYEGEOCn4od2a8HpwiNa1rF?=
 =?iso-8859-1?Q?+BIdbma/b+mKVB+BWsg99jXvAwbimRfBhBQal7FYPCeQlCGGP/PGo9Aqh8?=
 =?iso-8859-1?Q?dBOEVNRmREjXZY2pPCqCTWyu1u7VH55VcEFZYALK2+5hB5WdyNN40dZKef?=
 =?iso-8859-1?Q?sCUMV/6Iay/AdpXCzOdND/SYrFnlJm+4scDoRptXNJFRZQ9Y5M201xcoZq?=
 =?iso-8859-1?Q?MLvXQkTT5ay8PIRFr0Cy+Nc4PYzCJOe/i0zjyyfjWsVzNR9aPU+j4V1WW0?=
 =?iso-8859-1?Q?b43Y2stx0RM27tjPlTBvSkDUji/eR3uurLxZyw+adLw14FxY/hdiMyZqru?=
 =?iso-8859-1?Q?GrK2567fl5S51Pd8EJsf7zyjvRmwqrGKd5N+nMDsC9LOMqNaIsH+2yUVpY?=
 =?iso-8859-1?Q?e3lamiFYfuebzC5cx/cHwjkaek0OxI562hKInDWBDpcGlSDBDYr69gUiJg?=
 =?iso-8859-1?Q?q+wvGcQ3ebPLIeFwcu+7jvKOAHfGc3ZRHI6IrEhRB4/wnvBGlQ9UtJo+Fv?=
 =?iso-8859-1?Q?7xKyLWGZid1yknll9cHNX4sSZ37kbtwmb16yo/ioHouI0WN/tvk81HJi/w?=
 =?iso-8859-1?Q?3F3JAa86Yt1kga+2UWfUVQt1uN9CRdpwBQJfr5llGXV0QC/ICpwgjGa6OC?=
 =?iso-8859-1?Q?ZFl1zUFqpF/OIHWvTjKEiCR49fYxOL7KQAIz7QMPsvXD5vJ5uUNKtio5jb?=
 =?iso-8859-1?Q?bF1gR2XQJWSwR2LvgTUmoPLciEcXSFO1sXyt9kJzlPmQH3Na5YhRAxOrgn?=
 =?iso-8859-1?Q?5M3B6HmncdQF9KIjl5rSvcuy/6xIgdeq9hFCsft15LVSqzaqVnWCAMmmPa?=
 =?iso-8859-1?Q?MMsEfwSu/97HbWOr5LTDlvMKaIo8BF9YVON2NdiYNOkzpy0JPEBg3S8ZKa?=
 =?iso-8859-1?Q?iYOBeC6ghmp6NqKTudABgt3CcjRFGsYraDNfcYwXuloDHUBxManNxkcCYr?=
 =?iso-8859-1?Q?g4ovH69qRxYvCruMtzx/hwiR+R2JEWEedbY8ry7GT+u5Sl+UQ7A06manmJ?=
 =?iso-8859-1?Q?REe7/Ca92C253TuIloR0XTgaIWXm9x+BXL91TTh32egBRHf45k/Eif5Q4Z?=
 =?iso-8859-1?Q?H3lgqNFRaBok5JyQsfFSFaFxdAPUxZlbgOu1CApkOxo6T+a/W52oHqSpIx?=
 =?iso-8859-1?Q?IYERM5JihhrzrxTxtlv4s12kEUKF+VcZuwKxVEpPw3f2HpBxqJBiTgy21R?=
 =?iso-8859-1?Q?vOoj21MZ9pSUjjC/RhoSQli4+sbd7YAN9YTh6FJj/mJdhjrK3cCxBKVO49?=
 =?iso-8859-1?Q?DxxsF3Y3o/uTELQNjcw4yFCwn9aev96l8nwD2C935J4+WBty47SBA+BAxX?=
 =?iso-8859-1?Q?C4xQNegWlkj2NY+l5CI8h19in5lbjweMrG9s6qnzSz9qHOFjOeD6atvQpY?=
 =?iso-8859-1?Q?/iVPCA//pyROnJ7mv7GaApywsCmuFM3IolBvv04E+Ckx3a8brX5nAt6wDl?=
 =?iso-8859-1?Q?gRNnCLupeKPCvnfbdRjOHrcCgZ3KtgwWv+gU+7JjxpNnXXv+1rnQ9Y4OSp?=
 =?iso-8859-1?Q?a7GpnxuT2VoqPecWxFb8MTpq46h3Fvz7YniWUKppL1HxigInbEduAFRLT2?=
 =?iso-8859-1?Q?bKF1lc3WFVMI8wmH9SobLTMvmA2g7AdkLbFikVnmZ0ai+T7zrO5KnoPbRh?=
 =?iso-8859-1?Q?obtjt4viCiNR0/GR3wLBpt1CCmIWFSE=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 127cf09e-a7fe-4d36-7974-08def32b327e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 19:53:19.4144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WAtu+UXdtU9av9LAY33a840GI+iQ4Ko6RwIZCNsBK6q+JYgA6ATB+2eTQ8EwYI9u+onZBE3AnTPoG4svt49lZw+VyrqcjapRmC4GxwDLJ4UZFvuJwANYK4LdoSAqz5EV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9149

On Tue, Aug 04, 2026 at 10:13:00AM +0000, Akhil R wrote:
> dw_i3c_common_probe() takes the match data as a plain bitmask of quirks
> whenever the device has an ACPI companion, and as a pointer to struct
> dw_i3c_drvdata otherwise. The two are not interchangeable.
> A device that is enumerated from ACPI through the PRP0001 device ID
> matches the OF table, so device_get_match_data() returns the drvdata
> pointer of the matched entry. Casting that pointer to unsigned long
> enables whatever quirks happen to line up with its address bits, for
> instance disabling runtime PM or skipping the clock and reset setup.
>
> Look for a match in the ACPI table of the driver instead of merely
> testing for an ACPI companion, so that the match data is only read as a
> bitmask when it really came from that table. acpi_match_device() returns
> NULL when the driver has no ACPI table and when CONFIG_ACPI is disabled,
> which keeps the ast2600 driver that shares this probe on the device tree
> path.
Suggest commit message

i3c: dw: use acpi_match_device() for ACPI-specific match data

The driver uses has_acpi_companion() to decide whether to obtain quirks
from ACPI match data. However, the presence of an ACPI companion does not
guarantee that the device was matched through the ACPI ID table.
 
When an ACPI device binds through the PRP0001 OF-compatibility mechanism,
device_get_match_data() returns a pointer to struct dw_i3c_drvdata. Since
has_acpi_companion() still returns true, the driver incorrectly casts that
pointer to an unsigned long quirk bitmask, corrupting the driver state.
 
Use acpi_match_device() instead of has_acpi_companion() to obtain ACPI
match data. Ensure quirk bits are only retrieved when the device actually
matches an ACPI entry. acpi_match_device() also returns NULL when the
driver has no ACPI match table or when CONFIG_ACPI is disabled, preserving
the existing device tree probe path used by the AST2600 driver.

Frank
>
> Fixes: fba0e56ee752 ("i3c: dw: Disable runtime PM on Agilex5 to avoid bus hang on IBI")
> Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260728071757.5B3CD1F000E9@smtp.kernel.org/
> Cc: stable@vger.kernel.org
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> ---
>  drivers/i3c/master/dw-i3c-master.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
> index 3816a50a52cc..17e1dd4fb5f3 100644
> --- a/drivers/i3c/master/dw-i3c-master.c
> +++ b/drivers/i3c/master/dw-i3c-master.c
> @@ -5,6 +5,7 @@
>   * Author: Vitor Soares <vitor.soares@synopsys.com>
>   */
>
> +#include <linux/acpi.h>
>  #include <linux/bitfield.h>
>  #include <linux/bitops.h>
>  #include <linux/cleanup.h>
> @@ -1610,6 +1611,7 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
>  {
>  	int ret, irq;
>  	u32 thld_ctrl;
> +	const struct acpi_device_id *acpi_id;
>  	const struct dw_i3c_drvdata *drvdata;
>  	unsigned long quirks = 0;
>
> @@ -1618,9 +1620,10 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
>
>  	master->dev = &pdev->dev;
>
> -	if (has_acpi_companion(&pdev->dev)) {
> -		quirks = (unsigned long)device_get_match_data(&pdev->dev);
> -	} else if (pdev->dev.of_node) {
> +	acpi_id = acpi_match_device(pdev->dev.driver->acpi_match_table, &pdev->dev);
> +	if (acpi_id) {
> +		quirks = acpi_id->driver_data;
> +	} else {
>  		drvdata = device_get_match_data(&pdev->dev);
>  		if (drvdata)
>  			quirks = drvdata->flags;
> --
> 2.43.0
>
