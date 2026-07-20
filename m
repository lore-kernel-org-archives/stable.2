Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011057.outbound.protection.outlook.com [52.101.62.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC1D3C10B6;
	Mon, 20 Jul 2026 20:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784579255; cv=fail; b=mV36XMXlRlDbiXs30GBU/hLtODXZNM3CyiFUgIwywV+3nVmLVHv8wlg0G3Il+6/pzd3LWGw8w4BShkGnRUjAYEsb/GsdQd9gFTJYcn/h/7UDKdP7V1dQY+TQkW1YSB8IdY2Bqm8LEM/7B7zHHe4JPmVyrQsn4n0UqDszx9d/0v8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784579255; c=relaxed/simple;
	bh=RiLPkDpohL19RPUlYySLMIU1oafqyLsQ7sAURoJmc1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cU8FCC3/rbDKTooL8p7+xZsWQxFh+2KqkLG+D3ggLSTpa+E+TzcfiDcXoF32F+z+zAkjev3zRUUIYiwBePuhAEvEF22S1Rb/I3ACB0sjY2VzT7a0pZMrrciRcXCQQHAYcsPD+bTrjKPGE8woVTw2dNBROp0dAFhJANgbtXmhKnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tySky3UF; arc=fail smtp.client-ip=52.101.62.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tySky3UF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v2Ez+7eIDxn+OF89PcKDnemmnLrrf2SEUCej4FLRu8PpOnHAnx1myNLcyv90L8bbzvCC3vJ7ttBKMASRQzyR2HCrgYSMcqji6+4UyGhzcfTDg7sc1BsSYP4yV6VAlt6Sbc5TYTBK3TkLEmWE8nUxm283pajvqxFtJ1HSi+wP49QLDnzo+3c+jl5JykfSOCZ3NcrHBUDiCq+dHonAzuksuxUSbrYhmeJUYGIzSWYymxRyM7bp9vDK1gjehpfutaMBSYnRAy1mRvM602Qx7PAKHQUhC8dDhv61pMm37ETPZUM1oUiWnl4NhDcZ2QH4yK5UVZv1vaMUA7KksCsCM9m1og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lVerh133brC5eLn2ZjoUFVwH58pVJGzLFQMwEdeK0Eo=;
 b=JAELmMd24S5mqdMvdJhOUO4TmcvD6/VP0oTebhhYGXJGxuhxECXmNw73uOmPSJ0zj/n1LOJTaiiapCWXKl0wFcU0wyALo5oxtWY5KhoBrdt9VJ897ioxYyVX//oDmHJuyokV2rps+/x0IDyLUPm9XcblII94vt+Q0tdaRnmqdH9JuF62fBWcK2VFNu5pxEOHajyN2Hw6G66ty6IrgG+Tb+FcJ6ECG5qr6FxOqy41m1YtQmpAPnLq0gK/BmFGaVJFwqdn3a2tC2Fe7L4nhXgcRSWA84E1zzjumu1UPrz2Jxi/18y+Shcn6H2r8NZi03yHmKsb/sNf+5JzhQEBQwOaLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVerh133brC5eLn2ZjoUFVwH58pVJGzLFQMwEdeK0Eo=;
 b=tySky3UFLAhrgElq8t2Zk99IEq9OSyX9MRR+1UhVRHpz5cVhE7LVe3L1GYpANCvGgiXJ7wpGFRSiSGoq9o1QiGdQl6Fe/3T3BGoelvSvzNMRxEPtWV8QW7M37USdRSUYOTkFIyeuuC1XFImRJ/YRM8rUcFsqW/OiZKEg6tTIzlHxGVUxtskDXA6dWITNE6EEvurnHYhBtEi8OvldXG3df8B4f4+AsBJnEKwgm9hTkh8ffbkeNGy1ZSoPf30wAHV0sj2yfDSHqfYH0LhwOatwMFWMkOvcgWYxl/joJWnXoIX8rZH1cyPt97glNXjnRR1Q/8qw0wan/1Gy5fV5OfdZ3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7540.namprd12.prod.outlook.com (2603:10b6:930:97::15)
 by CH3PR12MB9430.namprd12.prod.outlook.com (2603:10b6:610:1cd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 20:27:28 +0000
Received: from CY8PR12MB7540.namprd12.prod.outlook.com
 ([fe80::4eb1:ab21:a9cf:e72a]) by CY8PR12MB7540.namprd12.prod.outlook.com
 ([fe80::4eb1:ab21:a9cf:e72a%5]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 20:27:28 +0000
From: Lucas De Marchi <ldemarchi@nvidia.com>
To: Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	demarchi@kernel.org,
	Lucas De Marchi <ldemarchi@nvidia.com>,
	stable@vger.kernel.org,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 1/3] xhci: dbgtty: Fix unregister on tty_register_driver() failure
Date: Mon, 20 Jul 2026 17:27:14 -0300
Message-ID: <20260720202716.76000-1-ldemarchi@nvidia.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::13) To CY8PR12MB7540.namprd12.prod.outlook.com
 (2603:10b6:930:97::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7540:EE_|CH3PR12MB9430:EE_
X-MS-Office365-Filtering-Correlation-Id: cc08148c-1d95-474f-516d-08dee69d5134
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|23010399003|366016|18002099003|10067099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	5RnI1pjE2AW+HgdU0G5iIUNOXfr6GBp1rpWuf+0ISI+AsjYNZc32e9FPj0deJ08DjkDzSArDFez4bCZLCDfhHz0DvPtw8eJaKitib8F+RIciZRW8tmdRnsykW+WldBoEPDY4CQDFE5ZATaTheemNRtB5NTaRV7Gx6iMqWXlo6Z0qDBhJcpnTb2skQiEf9Zn4/CH46U33ySkZBIM6cdOZY6ZhEDlonsrAy9G0KmTMAWBiYX23gugJIS73TZQtCK1Gv/jTmL5tFwS/SWTogFKfOLyWgVYLd/ASVZQppfLwKj1j7WJQjCRl6mB9XYQNmkAHOfGVffo2SZXI45Fb6zfGEdiBI8eI3uBlGl/HXYVHF6TqYA7UT216840by/snpxlGA3psP6EV+vhuvZ3wYOvxnUUnF+SCrP4N2K0/neIpHGE5v12jcvqP4hvK6kT98IBAu/q378U23oDlhl3a4LF8qG7A20xiszjU2Q2e/BVxOc+znyZKiHcz0PZy9I9fhp7mbiW5wke7oiuixQrm2El10FB4CXK7TwhCjFYTWQesNmUxlOBkbbW6ho47hVw4WlSiU2CbmLNkAAkzjDoQXPuOrqQKelqOx7wYyeyxIbHo2kMuujtdg6viaYuVkL4jR4ozRxCldcmt/A9RO61mFIYJy+rV+kJMXwvgcPyIOrdHsgU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7540.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(23010399003)(366016)(18002099003)(10067099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E5gCEnLkY3UnVLlxzOwlmZDJVtNHXrts1p4BSLsqvhC+zDwnloGmNqql5rHx?=
 =?us-ascii?Q?7biVBDgdMb1Un7JoDExyh4urhIFuABMyQk/lha18VLfkpZJ+FAaS6QXRba3K?=
 =?us-ascii?Q?E/Qf5q34ezdBFXlxmFapSjYhSDfhy9Ug8quZ2de1PSjjzDUWmyV/7M8FEJiC?=
 =?us-ascii?Q?TxSKF5U49UBNbPjAoG7oUArqaPZw6RGgR0zXHXOaDo5DpYZNNx7kXaeZC584?=
 =?us-ascii?Q?/PUrxO++SMBspG1I/yG3ib0wPkndPYgIqXBlZ/y3h1fUjq888LWq5yqBd3IO?=
 =?us-ascii?Q?CSddD82jMUUK89K1CV8eqbJukBojOjXGoEjLeRoznli0Qq1mTXTOGcy5ZTIT?=
 =?us-ascii?Q?ylm/O5fow8guup0P3x2wBC2GRwtwRQfYTZNGjrxs13tcR6++0j9o/UsUuZZX?=
 =?us-ascii?Q?JlRmM3yTk+KtL3ucUhppEny6KeLniO7kfy/fzpEiHqSosfr43HwIXE6n+IOx?=
 =?us-ascii?Q?LKqDrbkXZh8LdtVrZN1D5gEd9TElrTkYjc352npLWpqLazqi0TSt8ZvDpMJT?=
 =?us-ascii?Q?MlDJmTtzUQWmrQXwNA1y+N8S41M+cjzxKDwX5OuN2Y5WXlF3hUBMNAXPSyUw?=
 =?us-ascii?Q?p/+wOlZsmAmTC/8mSmr+aJsXo82VLBI+IrTJdbq47SO4pjd0gQxiQQbyCBQa?=
 =?us-ascii?Q?kZNo7AG66X6L7kHZ1HQSbuLuy1uibP8ttyn8HvK2USnJmpn3HPdXWPGLdOHJ?=
 =?us-ascii?Q?Bu8ykDR0WqzMtgaTD5o8Ttr9385LKwtiDA73wBEXL4ZqKdD6bYJHgucEZoDL?=
 =?us-ascii?Q?WW6a+W9Cb3SFGgIAl7lX/5LJJr+/tex4QYEsgLhp7YGq1/jB3uONzD3pn2JM?=
 =?us-ascii?Q?sAslj3MAS2FAcs3Ts7+gNGx5yonTdJ9zBe7gZYbBahNDmbMbOC+0xe395/1X?=
 =?us-ascii?Q?2topwz4azGiCfXsuATa46Csz2TwhVybUuJgCTLyznWrwYBX6M+l82tOqhsam?=
 =?us-ascii?Q?CG35MgxKSsIBPlsPUOs08R999tR30OZ5QEVdhNe3oGiygI/T3UWvDfyTYtQK?=
 =?us-ascii?Q?4cuTjMW7Qp3AjU31lnag+FiVQEUMUw/F+MwBrKZEoX5Kt+nN1PwkdEXUd5oI?=
 =?us-ascii?Q?MVxCxDeSNMVAqz49eXKOSSOcxQwWx1FX3QDby/78pJcqzcNvNA1KPomKU3f2?=
 =?us-ascii?Q?KW0lXHjScKNB/ojD5kX65LH4N8/Py/oXzfj31GqNVBF7UHrTCSQmlLR7aqes?=
 =?us-ascii?Q?mV+tvRM6lV7A7E8+CqfdT4zxtOCIYT7tJGYDYoufdXGZHtQOsjDyZ/F7aGFg?=
 =?us-ascii?Q?4XI4lMCJ101npweeicLY7mgMYAlqqvTQcKR3LzNnEd0KgJawOEpdwWou66BD?=
 =?us-ascii?Q?To3BfFqzlppTNMZ9nr75xPA5cjVzj3tmVHMkzKCkiDG5zflXSrvpCiilgEz4?=
 =?us-ascii?Q?BdyNob2+jRQHj0UvwtX0MQCGcJ/eKfIaDb7KCkrGLItHkWg6QWbV9PQqaXx5?=
 =?us-ascii?Q?gwTrFrOcusIisvTYc2d3ExFh1PyShQdcUL+WHCKbj9SN5jfLdFWVSw5uphnt?=
 =?us-ascii?Q?wicnwaOqc0BlI1z0SnDCfjg5OpUMibW8hgW/F7xxM6nXY7Hzwq7C4OLImIjI?=
 =?us-ascii?Q?NAa3j/2sKxLfGuuRiGsMCS4w6gmMOjr0K84nj5JA990s8sUnfnrZlqrb4iaI?=
 =?us-ascii?Q?0Bgg2cslP9OdlAYnhy17ppwhoNEznmL7XrgZj9clp1yKP3lzDzjKfVySt8mZ?=
 =?us-ascii?Q?p9Cv2zUPl7vN0Zq2QJtOgBOFdG762vhMGn2JrG0SXpgg/iABNXhafwYXH+pC?=
 =?us-ascii?Q?1WlVSY8NQzPUatQSYW9z0l4RSE0b49Z3rIcN8vCPZ9PYa/QarXqmGHvo94Ze?=
X-MS-Exchange-AntiSpam-MessageData-1: Fr3W2E0sNBESFg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc08148c-1d95-474f-516d-08dee69d5134
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7540.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 20:27:28.0834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3JOMvmuGHTiS4YjU9BfronmjPuLIIh51yNeEiip9Hz+vZiJ+G1CijkiUQdiOOoS687WmuXY1k9rx4E8NwDvVSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9430

If tty_register_driver() fails, it drops the reference, but fails to set
the global dbc_tty_driver to NULL, causing the unregister to be called
again when module exits.

On module unload dbc_tty_exit() only gates its cleanup on the driver
pointer being non-NULL, so it operates on the already-freed driver:

    module_init(xhci_hcd_init)
      xhci_hcd_init()
        xhci_dbc_init()                       [return value ignored]
          dbc_tty_init()
            tty_register_driver() fails
              tty_driver_kref_put()           -> driver freed
              (dbc_tty_driver left dangling)
    ...
    module_exit(xhci_hcd_fini)
      xhci_hcd_fini()
        xhci_dbc_exit()
          dbc_tty_exit()
            if (dbc_tty_driver)               -> true (dangling)
              tty_unregister_driver()         -> use-after-free

Fixes: 4521f1613940 ("xhci: dbctty: split dbc tty driver registration and unregistration functions.")
Cc: stable@vger.kernel.org # v5.10
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Lucas De Marchi <ldemarchi@nvidia.com>
---
 drivers/usb/host/xhci-dbgtty.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/xhci-dbgtty.c b/drivers/usb/host/xhci-dbgtty.c
index 2e7384c6b6ec..01decd46f313 100644
--- a/drivers/usb/host/xhci-dbgtty.c
+++ b/drivers/usb/host/xhci-dbgtty.c
@@ -651,6 +651,7 @@ int dbc_tty_init(void)
 		pr_err("Can't register dbc tty driver\n");
 		tty_driver_kref_put(dbc_tty_driver);
 		idr_destroy(&dbc_tty_minors);
+		dbc_tty_driver = NULL;
 	}
 
 	return ret;
-- 
2.54.0

