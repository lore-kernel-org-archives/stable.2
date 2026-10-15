Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013007.outbound.protection.outlook.com [40.107.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE1F4248A9;
	Thu, 15 Oct 2026 15:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792080012; cv=fail; b=kkXtDG0+InnBrZhePdWEa6WO/EXPlUTnxfAebeXuJ/lZ+WX0qmZz9XaSvUycx7avVNQjPEIUIXMEXhq+XVbAGOuna65/DCTbCJ3XKapSMlCnqh+pCCCnlVqmZoCVGq7Ps9F/ij5+Z2nPF3QUYkYJtPnUKEwuBzSzeEmVBNW5OT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792080012; c=relaxed/simple;
	bh=iBIw6FMndJEay/80zoXLXq1sXSg+vnXe/pHhstpklO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y/ydV2thnin/ojnrEMqMPsJBzUpiZguU6JT/AbrhZEDX16WRt4SfGf8VTR6VR1VM7TybnN9e93anO2v543pI1EitoQ/wK1J+khoT3oYaTn+VQg9KJa48ERulKbJrZ0Yxux3GyRPuXu8XjScgoXmolDOqBVlsT3BlcTiSIyoXp4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MkW5atwF reason="signature verification failed"; arc=fail smtp.client-ip=40.107.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MkW5atwF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oSsFSXQL0KFMtoXwY5WLSlpJAANa0t0BCd3BAlCjjb1yTWicjTj1NvVbFlayw62pkhzV9thTOyUoNaCaH+Clk5DIdfsduizfAEh63gKD8aM2rdF64Ss1jhYiLG3gzOyowPB1SNLnRf9Or0p+CTAUGUmWdKmm9G4cjFxyxW9c27vf40PV9tfHynDrWqBSF4kvQanczR/WEz9D0g5OiRKz4IrmJ93SuW/bnnsdjBKhy8txQQuecHUXXzH5cOAwXDr+lpYLe5STsMcX11FMw0UQOWj+b9261JbAAhC5XJfn8QVXffGse1q1wHkOqQKJwx/BtkyaPBYIoa1Ya5UC0afNSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWmNvx5dXXswABTO0onAPXjtcBo8uUo9wz6rMwtXMRM=;
 b=lLPbXuNOgOZaU4ZEaJRyI/m8jsd1ZHrezZYd+YV28CIg24am8jgQgdcP9S7kVzGSZYi2qkdZRNFsh95iD5hCpm+drFHQj3dvEzlrsc51y41REa08i/WFfbFVF5S4FDemzXRIFxAD6u27ccjG6+f0JrWa0Q+P2qJMIRXo4kF3pfFIr6QBz8a604/0BdMpRkCRGNj8DRG4ZQAtSnTuuTSTlRlIFa3hj9fwHfW3vPCkmCnJwzbrsXWKoTZVJkYGuCe2DsUiBvW/gL5kQTM8wupyhz8oKctVUdQ8L+mkiP96j6GnPJgIPy12d0XVRBco0FDCzXTC+gYDrJjAJRYUq27gtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWmNvx5dXXswABTO0onAPXjtcBo8uUo9wz6rMwtXMRM=;
 b=MkW5atwF1xRlFWQWPmzLKCpA3PyWf54ZCcto8gZBfgXg4UvsRdYHxZMXUw0eHrY9PIpJS5V02eE6r062Y3JWe6WUgs0XBUI1K24o7jKfBwjmEx60XVWs2KRmGNKZDmtBChgLBY9KgnMMQE7GFP+/t2qLdUb11Ayx+6X6Hw1IjI18NH8vp0L3Kg6e85tEI/Ejv/XeQpZJqVWDMCc1rRvUG33xUgC/RSV6TOU3a79aSXzaUJPhpmAS9HT8sW9VcwrVeFfkhpE9guwRxEsbY37dR18b+VQkaT7LgFb5gjqmwnV6SXwup7md7MW8sQS5wgul7iJe2/kQ8U+GWZomvlsmOg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by PH0PR12MB8799.namprd12.prod.outlook.com (2603:10b6:510:28e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Thu, 15 Oct
 2026 15:59:54 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 15:59:54 +0000
Date: Thu, 15 Oct 2026 18:59:44 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc: Til Kaiser <mail@tk154.de>, netdev@vger.kernel.org,
	stable@vger.kernel.org, Petr Machata <petrm@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Vadim Pasternak <vadimp@mellanox.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] mlxsw: Initialize register query payloads
Message-ID: <20261015155944.GA1836432@shredder>
References: <20261014173117.26305-1-mail@tk154.de>
 <87a4of8kw1.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a4of8kw1.fsf@all.your.base.are.belong.to.us>
X-ClientProxiedBy: TL2P290CA0017.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::7)
 To PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|PH0PR12MB8799:EE_
X-MS-Office365-Filtering-Correlation-Id: 90550843-618f-42f7-5037-08df2ad559e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|10067099003|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	U2w1ggVvqs+jUUNN+XPiDOkoC/wFgYlY2WDFm+vF3GcOV9KquiIfu8nYQDzE2Ilch36piBIS/7dX2iYM3mlDLTG1RinyCqE83MEsFQxujCDcAUHnCK1JV4mV7Lvz0SQagpxRqU97JLPO6Z2gXF8bB19VNzcrMnGrpa+NtvdZiHdNZ/bytWrJnckxxjSx/kSRk4VajKvdmfshgrZFI/w24J1uPXNc8FZ+/yyKbcx8lBbnR4CBRGssAOas0nIdRxcV+EwbCwr+aw06h7PGiCU9X5EflXYJM6elhHj68cvbIYdhGvYKGYt55jpYS1YZMEIlRDexq6KL5/N7pGQWyc45JUo6UghWW4LIq9wGiegsj7XujPO7xybZhABYQt9bp7NFKr1zRTgcPZQmkz7let3zCWpCwLvGbwwJ6F8CsL6+mv+oy58W2WhbwiHnqYSzFZzVq3PHTftVMOUDQaDGgx9m4+fZKoEwcdo6nEKGNtBySCCSnZxojBqz4mJ9kaWagYWjf1biU7HuotsmaLa7yVz2yjqcrvH07bZg7iPoWZrJSkDtDyDBiICep6bbLVYVdvjcHb0fnV/XXdb8z+gi1HDjnAo+bfYtYQVT98l6E2aacFu4YdMQg9rIfC8NDN9ThYj67oQXdGFBD8umLZ/bmcBfVr2ohljek678NMYYaSjZCeQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(10067099003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?n2t+KABilDuA+H+lrjxM+FgAZC+C7wNsBlvy5fXYwXf8tFJQJpk3NoTt/I?=
 =?iso-8859-1?Q?kniVYxNlGg8SJbvcVTTmWW9rFjWQnBiBRPBQUOy1b6mjZIhsR//TtH/SRe?=
 =?iso-8859-1?Q?2oBl3vhTBQ4qcy15aVaQFh2lPXbTcLbMvFKTiyuhSOchbYhb1D3O5KzxxY?=
 =?iso-8859-1?Q?0idwbyK82T70l1jojTBMr8Et5uvSGtAhs/gtwy4mgc4Ig/weexzlpDU8vT?=
 =?iso-8859-1?Q?V2uPqOBJDNPeDXk14Rl3wXL/m9qivGdzo+XuBUyG0qzFsxqmWbeQPvAhVS?=
 =?iso-8859-1?Q?4y4aS1T82f+NkEhRYrNdhgEsGVxfoyxo2rdbufCOKLUHopgbsrT8YGoPO9?=
 =?iso-8859-1?Q?ltlW6bNlTWcCmEy+fQV3fzRU1DYEDD2tQHwXrdBD3d4jm+NikLScv9CQ+X?=
 =?iso-8859-1?Q?02eURf22bnjYVrY7Wacz+Dq7W/29m9toSXcU7FFhQrad5En26ZhRwnpyJ+?=
 =?iso-8859-1?Q?nJDZ+bMBI/N7IONn/Mrti7LwjcERFyUN17ibSVuuaAtazUlS3XM3ylkpvT?=
 =?iso-8859-1?Q?ZeNKeq2nGjGJCdJ/Yd0SM9VCHAjucl/3HMfgxb3OytSzR/xGB/Gp0llKfX?=
 =?iso-8859-1?Q?2djw4GWnBW8oarFF4qekNWQzJEGvk2X/o2TRBHL0gwQEa6yHNPFfx9nz+M?=
 =?iso-8859-1?Q?0pDz5utU8i5WpgV22Zj652vqNVUG1JP6GkTwKWURqDXkUcGQSJpB5N6wih?=
 =?iso-8859-1?Q?e1jD2VWOwFL/n3Mck79KvnARBXPOukeLR59+T18KeSdi4i+41dm2+Hox6s?=
 =?iso-8859-1?Q?e7Og1/HBWeWacARzG2XUSu4Xq2v5Qf7rZpWrNHOd2aRapqzjnsJcGsB+br?=
 =?iso-8859-1?Q?A27IaE5a9gUwRmjYjC2aSykNXmOCpDI7Omc6LYPHZOoFpb3in1uJeWxusA?=
 =?iso-8859-1?Q?q5ikb8YdW1v6IzkeH17XvDuM8Lk8xZzuMX3Rni46uD1D3uVD45VWf8oVOJ?=
 =?iso-8859-1?Q?+HUMb1I/y62/L0cYAt0yKX3D2v/w4EHu5JLUF3EEYqmcCj58E56SB68m0r?=
 =?iso-8859-1?Q?s48a3AisiVmy3RCPCyhhKSBgnSYs/EoYAqbF8t3x10NhBxjeVtCJqz1a+B?=
 =?iso-8859-1?Q?njjZqrTgrsswryN6u52DNJlHoR/K+M56mIenH9DSc3WyBRKIKTES++v+SI?=
 =?iso-8859-1?Q?6gxDPW0/CiA1RY9iiDO1nfRepwA/WkOzuk61P97hEHKIsRncE+CJH8FxFh?=
 =?iso-8859-1?Q?/st5JjfggSacUS1X0jBquccxT8ET+u3pSKZFgrl4whVNiJEF55q9U0Fd/O?=
 =?iso-8859-1?Q?mxBlOXpIsNiE92aM4vI2JqzrElpXOakyKLQ7AIBJZGgTf/Q/YVsMF8DJtv?=
 =?iso-8859-1?Q?t+NuWKw2ovVK1Y2K8d6LHDujah98lFd79JWuCa2EVmUN/GFw9PY50/p2mm?=
 =?iso-8859-1?Q?Z4ahfFmnph7P6t0aUchI0IkVCB3LvOLpK5V99Qxp4vbGXk6mGhgcnYOBwE?=
 =?iso-8859-1?Q?8JSCm/ZNWYzjFXOPjtNZEEsISKG4/9u/AhtUIvU3qg7Rr9kB6AoaAEOvpJ?=
 =?iso-8859-1?Q?IW7Qrq32a5oAvVM696L8tpLYtG/prqLR7LjXrQS5XZn4inp6OOeZXrKW5/?=
 =?iso-8859-1?Q?auqiurdS0GSGqr94MI0pczYW/RSHM+pQn6R+iU9OJm0Ii3yCVMyIHrhusy?=
 =?iso-8859-1?Q?ej+WCFUntnClklH54GYGGAK36fFJcrshQX1/dAj4m2SxDmPvKYTqDYnFcn?=
 =?iso-8859-1?Q?T2U5tneBQtRYDL3MatmtZEydwJVIwTsp3uOC/vp2zH7kcOFfmF35WHlhEe?=
 =?iso-8859-1?Q?Spfv8CkbfjUGGC/blk41fCBjmB2EwxCXM1Qk6/SxgJvaubbkBGSyRtTBA0?=
 =?iso-8859-1?Q?vqTKszymhA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90550843-618f-42f7-5037-08df2ad559e8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 15:59:53.8172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6G0bfDDhrFnzYFyJy7JTZvTFGaddMsUuDB8e1fhvbpr9J9AxT5LKtM0w6cAEXnTXJUQb3Cy9aUb3M/8Ahnx68A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8799

On Thu, Oct 15, 2026 at 09:48:14AM +0200, Björn Töpel wrote:
> Hmm, isn't this pointing to that the query should be more robust,
> instead of relying on zeroing receive buffers pre-call? Maybe just fixup
> query instead?

Most registers require an index, so the common pattern is:

mlxsw_reg_*_pack(...);
mlxsw_reg_query(...);

Where the pack function zeroes the payload. We can't zero in the core
because then we would overwrite the indexes.
