Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011052.outbound.protection.outlook.com [52.101.62.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F21C39AD34;
	Tue,  9 Jun 2026 07:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780990865; cv=fail; b=QKPsUIbjpCCB1ry2ioC9vBNUXmnK+eyI4oK+KMUkQIkges3GA6L/uo330Oqth4YzX9DWgTHtPJKq55YqjeUYmP2W0qDZfGSsO6Unebjg0u/1EnsgRNhvkPrnghUzmI5y3rk8MDvFZGJABvCq04hEr0PYA1G+ypgk51jBToEZfXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780990865; c=relaxed/simple;
	bh=rqojo1/glrZqWngFKZRlDotE/dwZLEiOAkCWJoAVV/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=STquVzjSOzg4Hl7Tjoc+cIpy1pX5isjC2Qk9vLAU/qXbeQGPBhpNBPJXhjkcwy6xIGZO6xY0FZ69P42qhglKh9UpbCvgqsXeWl/o3+aqiSuqP9K7ktg8eJfGOVSZ6kRHOJWRfY2FAHraH4JxhXGE/QR2jKoVKU/5Io8eEuap9sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=crOVYHCM; arc=fail smtp.client-ip=52.101.62.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="crOVYHCM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hueLzOQguL86l7vknZNcJOWTPA/SMy6pMP7KcTFipRY3SZQELBKZ+kA8gz1FywcrjpxZzl0DTiYOqjVTE0M8Kt7DP1+WcM0nUuhFTKCm0ZF94m6da1YKiRluZLV9Z/a2LdVXPovbchzUO/xdUEuiuP30ADBohbdATae/0bx2yd24wpOdi0QxNCwMcpS3+Ba+DUEgkfdSGMhbh5Pj5UfMRe7Syn56teXu+vRAKl9ikv2dePLInH3YUY85zLzyc6UoJrLjzPjFaSeTSrnlk0nAT0DQkJF1+FhITLLRcTF1nHYcSmd5WeyYCbdBF+ig845gU4y2SO6Fw2h2vT8JDXrdjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CGMYDTfvbCDH4IaE/E8I1xTd9QvgU/7yx+gkxrY1TzI=;
 b=LZPUTwoSXT0OWbs21Qjn2kH7Jba39Dq4iMcR8WrI2FYCEIKA/QzqOedGAIfUGrTvXWV3avgjocrAsUqlbI/PefaOWsApWs8yd4HP8i9OoSG99htuX8A/z304x4OXxRJLdyUUTa6oI53kXULqpuQ1uCdA8gwEzp8uub/AIj+tS+mpv0kOaoDW4PvqBklvXLCMDX/qQa5GAQ57lvDg/HH6GswFS8eOuTvfYdzvZT19s+SxY9YHT2iSfPV7Xbjg1u/F7dzepN1N55Q+2LifFZ3XJpu9vKtZCemjyUhFMNraudC0fH+euKYZp/z/utVSiZSifh8EJL2+vZqNnUl/ZLb4Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGMYDTfvbCDH4IaE/E8I1xTd9QvgU/7yx+gkxrY1TzI=;
 b=crOVYHCMxwPJkqrXJ7uEGv8a/nuld71pGqjsfJwIvhazdGKgzMMAbkaYiF5u8C5d43tTc+QZMYNVahcWNlINm5ZS1TKeJw8pl1k4QHo6BtHfnziAaliUqMLywlf4XpRor/bCg7xnzNWG6Vs2Wog8v+faqRLANb/TeE8wRBVDWOe2q1DpKkxklFsWs7lrpRqHIgzvy29XkO31pXnp6jVpUPCdY3BSnwoH/qtct58J0z30cIOn5ZMJ6sDgEGVqQM+QuRr8rUX5GcXnDk//FBAKzRCt3yFDihwraeDQT7VxVbwww4lD4Qctcx0bRi72TmBEeLAoa5heeSky1YrGSPDkOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DM4PR12MB7741.namprd12.prod.outlook.com (2603:10b6:8:103::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 07:40:55 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 07:40:55 +0000
Date: Tue, 9 Jun 2026 15:40:45 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net, 
	jic23@kernel.org, alison.schofield@intel.com, vishal.l.verma@intel.com, 
	ira.weiny@intel.com, djbw@kernel.org, ming.li@zohomail.com, rrichter@amd.com, 
	Benjamin.Cheatham@amd.com, Smita.KoralahalliChannabasappa@amd.com, stable@vger.kernel.org, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
	PradeepVineshReddy.Kodamati@amd.com
Subject: Re: [PATCH v2] cxl/port: Fix missing port lock in cxl_dport_remove()
Message-ID: <aifBp346jcVZ6sgi@MWDK4CY14F>
References: <20260608223533.583278-1-terry.bowman@amd.com>
 <be149ddc-702b-46c2-b6a7-d9195aee0eee@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be149ddc-702b-46c2-b6a7-d9195aee0eee@intel.com>
X-ClientProxiedBy: SG2PR01CA0182.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::20) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DM4PR12MB7741:EE_
X-MS-Office365-Filtering-Correlation-Id: 329c1268-2d29-4fb3-fb71-08dec5fa7013
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|6133799003|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	LqOTxQtRGIRDQ620Mfcu1i7skoZAhV4iVJQdSum8+VPXvBuGb1RSW3yXFJPrGYE81i0T7rg2GdAAhyABfZmJd3+PzGuGtILJB7nCsAZDVYbKMLecF9XEiX0Wa7a17U7izLDAzfCOycsHaO9yFWTQMGO3fvqE4SQSVy4X65pQ64BAwFwjUCZsCozdyS2UBxvmS7Dc9v/v+hds3s0PvfO7k8T2Y9cmZRCV0FPnzjfITLaYPAVu0/ukX+wZ4krq+TVnNfpFwASTumJp0X0yew/0rRTeVzK3JjbGqsxef5i5VGsVhAInvKXvSFGw1DaY2FjQAYPUTjWdmlW0OKSd165sK8Ld/MTpQRi44VA5ur5zWak4yLMKbsrTsdEhsAXV4l0jaBv1Vh1pU7MSHzghP87vO6G13VKs2YQDnN4Wol/WkNRzcB2FZFCe+DAQrcskUstXLiVNw08CMAyYIUdOMF7QirLH7bIhhp05dhihoU8wQliTiOTvItIZqpyKwTGx9ubp3Y6bXDyb7TCRBNiVDQ71FJoeieS7nL1ix7E2HDZWsnOojx40QqdAO341wSQFeiSwQX5YJJXseBJgpqK7PDh1wUJdkASWo4vVCK/5mFArw7BKxrAq4MELLLWpjX5hylZvIrZQhJJSDR/pzYwGdD0SodCCWuU64kV5Nipr82Uwt+Oyl5D6cFByWpySCCsIvo5I0rvz4OQ3pkC/Hb4uiUQn8g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(6133799003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SkRJn9eoYcNeEOAZ1dudXqbG7B4HV/vZmmF9lPJ8dV6p7F9F45Trvs3ufkWA?=
 =?us-ascii?Q?tSvJbfdkgTnAgsDh3JuDSvwUQ12PZjHmcuNK9DNKqS3GLMzJge4wu1jl6GxR?=
 =?us-ascii?Q?pg7cn4srVehbPmkbXBOLQCs9MHZSSC8SyFw7ggHaDT88BQhGeuTcf20Olkj6?=
 =?us-ascii?Q?PwKPeP9MtCK1YBqJi0HRbNNe45gB/scxIFJD1gShwBwIFmDTphdFYUGYJD5n?=
 =?us-ascii?Q?gGCDmFupFJnmEO5lYG4p37VoVUQx41szYYCoWQKAnCu43BD35CqmZotUXmq5?=
 =?us-ascii?Q?6Y+yHOh4DMWVNt1dzup4ujuOqfJPHv36GLytO5Tu6d6KuVGSYekaw7jk9buK?=
 =?us-ascii?Q?Mb9f9tOEXsEUg1drpETdYaGP+nxPXjo/u28Ex5VQmUClFYKyZyfIyeo01bjk?=
 =?us-ascii?Q?wtlYEr/yjYVPITMqprOeL5UbY8ZpzSdC3JokrLX1JRD811AzL0zLmoreCNKH?=
 =?us-ascii?Q?dv+e3mSqsWynO4EMZn5dADIBdhB7qx1iFLwASwEvd4EziEeRFsqjoU6xmwV3?=
 =?us-ascii?Q?US4u+lpZR0JhZy8bBvtxLsExFI/sp4cdvBA4HRAXU37efTwQLOxsN9SK36yr?=
 =?us-ascii?Q?TlpAp194S6mqVFjA3LdkCzbr87yyiNd+KpBEPrYKIOfKhxsqu4sNI7kmVa9k?=
 =?us-ascii?Q?AFoXWwiSrwE9ZCtNhAntvFk5Q3C5JQLu2aC3n+Ka3K8woRT1/B9OCvnSlYk5?=
 =?us-ascii?Q?0GMLzlRhQmi575i0wjKUmizioVe+DS+M3WJe6EbEjORqccjNJrYEdfs6zl33?=
 =?us-ascii?Q?odM4hQ+SBllvWKDtdnN/ynQxOpG7d7uPDA9DzfScLKgDzvND7brQql+G6ax1?=
 =?us-ascii?Q?uWdFnsnWewROSG/AqVCzlelrFLfdKxHMbDq8ZvsgUQnDFsrZZuHUUXhywG3Y?=
 =?us-ascii?Q?gxZ4vVQQxjmD0EO2GIF7B0HSn+He+m3r1v/6PUrsW4zhe/vwXEBmwPY6T94s?=
 =?us-ascii?Q?Vkyft/eLe5gt3axhyxK7sHT58OKKzRzh7S9a2vw2C1cn8gezwsXvxsn8dxeT?=
 =?us-ascii?Q?Y885DLqPqVhHVeHEocpxtSa23jYBX6AdSOdM1rHMiCv413K6vEqkC3a8XfaX?=
 =?us-ascii?Q?CWnYUpqYF17/TY6Q2FaLi+EXfK469R7cGtNgJSrEZfj726sCkw4nWGp4qlwI?=
 =?us-ascii?Q?sSG8Y2Yu5OkdShjA7+x9WDk0oYFvhoaKnQJ9KfUF4HQFE341B6pxNvzbRLo2?=
 =?us-ascii?Q?PhitqTuJsDAmf/VCSy2gSX5ukDq6aSWVqmBv3ioO4Q06thjOtlE2/k3eR241?=
 =?us-ascii?Q?gTRWNtbz7cO3Q6itpPEZrtBHFlun1AUla9DwOPQIdIXUI2JRpblilyFDRW0m?=
 =?us-ascii?Q?DICvuXOocH03paqVrjiNCZ+dQBEXbO2Cv9sc5lU2IqRAsuBF2GRJ1lI5tVeh?=
 =?us-ascii?Q?lt49VAuVr6F+UgrOijOgHpLGVAvE2oHAelFiOVpuq4WQgwP1hxjpheyMZH89?=
 =?us-ascii?Q?Ckey4kJimNO+uDwGtRGjP1cZBc3CqA5I2KLw0C7+QYmF8lrZfwoTnHvp51Cg?=
 =?us-ascii?Q?GiVdf58fsVCGKlVYR4gAonvvCblbtD9JiRD7VGMXAIllyz8i0VIEPVdZSvzh?=
 =?us-ascii?Q?9xhg2pK3Fs+xbaGmOy/OhPevqKTolYCzC2s9ZTObJP5KwIP8F0K/VmsE8XMo?=
 =?us-ascii?Q?0B8ZkWICZiMQfNd4l09EA8oCTULMSDq6PJyEuY5rmDeN61AC18DhzLtz4I0q?=
 =?us-ascii?Q?A2gFDEMO/7k0hfwdJ7mnOLemFAKIRuFxSflvlw8bcpAisXlUpbRqKMHyKRtt?=
 =?us-ascii?Q?FXrHDvEQmg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 329c1268-2d29-4fb3-fb71-08dec5fa7013
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 07:40:55.2628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6amRl60KRv3bOiZFBP73NX8ik1B5YhO3PQIkP1qDUULiJYf1G5XlWf/cn6aY/r0r5cMTEMDYQJqQUIlbjAiVEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7741

On Mon, Jun 08, 2026 at 05:35:23PM +0800, Dave Jiang wrote:
> 
> 
> On 6/8/26 3:35 PM, Terry Bowman wrote:
> > xa_erase() in cxl_dport_remove() runs without the port device lock,
> > creating a race with any caller that does xa_load() on port->dports
> > and then dereferences the returned dport pointer. A concurrent
> > cxl_dport_remove() can erase and free the dport between the xa_load()
> > and the caller acquiring the port lock, causing a use-after-free.
> > 
> > For non-root ports the port lock is already held by the caller on two
> > paths:
> > 
> > 1. Driver unbind: devres_release_all() is called from
> >    __device_release_driver() which holds port->dev.mutex.
> > 
> > 2. Dynamic endpoint removal: cxl_detach_ep() takes the port lock
> >    before calling del_dports() -> del_dport() -> devres_release_group(),
> >    which synchronously runs cxl_dport_remove().
> > 
> > Use cond_cxl_root_lock/unlock(), which only acquires the port lock when
> > the port is a root port and the lock is therefore not already held.
> > This matches the pattern used in __devm_cxl_add_dport() for the same
> > reason.
> > 
> > The write-side fix to cxl_dport_remove() is necessary but not
> > sufficient. Callers that obtain a dport pointer via cxl_mem_find_port()
> > use a lockless xa_load() and must not dereference that pointer until a
> > lock that excludes free_dport()/kfree() is held.
> >

Hi Terry,

I think the mechanism is right, cond_cxl_root_lock() in cxl_dport_remove()
is a no-op for non-root ports and a real qcquire only for root dports, so
no deadlock.

But this only cover the 2 cxl_mem_find_port() callers. The sibling
cxl_pci_find_port() has similar lockless xa_load() plus deref, and those
callers aren't fied.

Could you either extend the same fix in this series?
I'm happy to send a follow-up for other readers if that's easier for you.

> > For root ports, dport_to_host() returns uport_dev, so all three devres
> > actions (free_dport, cxl_dport_remove, cxl_dport_unlink) are registered
> > on uport_dev. __device_release_driver() holds uport_dev->mutex for the
> > full teardown sequence including kfree(dport). Holding uport_dev->mutex
> > on the read side therefore excludes concurrent dport freeing.
> > 
> > Fix rcd_pcie_cap_emit() by passing NULL to cxl_mem_find_port() to avoid
> > capturing a lockless dport pointer, then re-fetching dport inside the
> > uport_dev guard via cxl_find_dport_by_dev(). The previous guard on
> > root->dev was wrong: cxl_dport_remove() releases root->dev before
> > free_dport() runs, so root->dev does not protect against concurrent
> > kfree(dport).
> > 
> > Fix cxl_mem_probe() similarly: pass NULL to cxl_mem_find_port(), then
> > re-fetch dport inside scoped_guard(device, &parent_port->dev) for the
> > VH path, and re-fetch again inside scoped_guard(device, uport_dev) for
> > the RCH path. This closes both the TOCTOU window between the lockless
> > xa_load() and the guard acquisition, and the window between the two
> > sequential guards in the RCH path where a concurrent surprise removal
> > could free dport before devm_cxl_add_endpoint() dereferences it.
> > 
> > Reported-by: Sashiko
> > Fixes: 391785859e7e ("cxl/port: Move dport tracking to an xarray")
> > Link: https://lore.kernel.org/linux-cxl/20260505173029.2718246-1-terry.bowman@amd.com/
> > Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> > Reviewed-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> > ---
> >  drivers/cxl/core/port.c | 10 +++++++
> >  drivers/cxl/mem.c       | 65 +++++++++++++++++++++++++++++++----------
> >  drivers/cxl/pci.c       | 17 +++++++----
> >  3 files changed, 72 insertions(+), 20 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index c5aacd7054f1..0b8f144596e8 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -1092,8 +1092,18 @@ static void cxl_dport_remove(void *data)
> >  	struct cxl_dport *dport = data;
> >  	struct cxl_port *port = dport->port;
> >  
> > +	/*
> > +	 * For non-root ports the port lock is already held by the caller
> > +	 * via devres_release_all() during driver unbind, which holds
> > +	 * port->dev.mutex throughout.  Acquiring it again unconditionally
> > +	 * would deadlock.  Use cond_cxl_root_lock() which only acquires
> > +	 * when the port is a root port and the lock is therefore not yet
> > +	 * held.
> > +	 */
> > +	cond_cxl_root_lock(port);
> >  	port->nr_dports--;
> >  	xa_erase(&port->dports, (unsigned long) dport->dport_dev);
> > +	cond_cxl_root_unlock(port);

In the comment above, maybe worth adding some contents about this is
also what makes the RCH reads safe. It's no obvious for me.

Best regards,
Richard Cheng.

> >  	put_device(dport->dport_dev);
> >  }
> >  
> > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > index fcffe24dcb42..345b56f215ff 100644
> > --- a/drivers/cxl/mem.c
> > +++ b/drivers/cxl/mem.c
> > @@ -70,9 +70,9 @@ static int cxl_mem_probe(struct device *dev)
> >  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> >  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> >  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > -	struct device *endpoint_parent;
> >  	struct cxl_dport *dport;
> >  	struct dentry *dentry;
> > +	bool rch = false;
> >  	int rc;
> >  
> >  	if (!cxlds->media_ready)
> > @@ -107,8 +107,7 @@ static int cxl_mem_probe(struct device *dev)
> >  	if (rc)
> >  		return rc;
> >  
> > -	struct cxl_port *parent_port __free(put_cxl_port) =
> > -		cxl_mem_find_port(cxlmd, &dport);
> > +	struct cxl_port *parent_port __free(put_cxl_port) = cxl_mem_find_port(cxlmd, NULL);
> >  	if (!parent_port) {
> >  		dev_err(dev, "CXL port topology not found\n");
> >  		return -ENXIO;
> > @@ -123,21 +122,57 @@ static int cxl_mem_probe(struct device *dev)
> >  		}
> >  	}
> >  
> > -	if (dport->rch)
> > -		endpoint_parent = parent_port->uport_dev;
> > -	else
> > -		endpoint_parent = &parent_port->dev;
> > -
> > -	scoped_guard(device, endpoint_parent) {
> > -		if (!endpoint_parent->driver) {
> > -			dev_err(dev, "CXL port topology %s not enabled\n",
> > -				dev_name(endpoint_parent));
> > +	scoped_guard(device, &parent_port->dev) {
> > +		/*
> > +		 * Re-fetch dport under the port lock to close the TOCTOU
> > +		 * window between cxl_mem_find_port()'s lockless xa_load() and
> > +		 * this guard acquisition.  A concurrent surprise removal can
> > +		 * free the dport in that window.
> > +		 */
> > +		dport = cxl_find_dport_by_dev(parent_port, cxlmd->dev.parent->parent);
> > +		if (!dport) {
> > +			dev_err(dev, "CXL port topology %s not found\n",
> > +				dev_name(&parent_port->dev));
> >  			return -ENXIO;
> >  		}
> > +		rch = dport->rch;
> > +
> > +		if (!rch) {
> > +			if (!parent_port->dev.driver) {
> > +				dev_err(dev, "CXL port topology %s not enabled\n",
> > +					dev_name(&parent_port->dev));
> > +				return -ENXIO;
> > +			}
> > +			rc = devm_cxl_add_endpoint(&parent_port->dev, cxlmd, dport);
> > +			if (rc)
> > +				return rc;
> > +		}
> > +	}
> >  
> > -		rc = devm_cxl_add_endpoint(endpoint_parent, cxlmd, dport);
> > -		if (rc)
> > -			return rc;
> > +	if (rch) {
> > +		struct device *uport_dev = parent_port->uport_dev;
> > +
> > +		scoped_guard(device, uport_dev) {
> > +			if (!uport_dev->driver) {
> > +				dev_err(dev, "CXL port topology %s not enabled\n",
> > +					dev_name(uport_dev));
> > +				return -ENXIO;
> > +			}
> > +			/*
> > +			 * Re-fetch dport under uport_dev lock.  uport_dev->mutex
> > +			 * is held for the full devres teardown sequence including
> > +			 * free_dport()/kfree(), so this excludes concurrent
> > +			 * hotplug removal through the entire dereference.
> > +			 */
> > +			dport = cxl_find_dport_by_dev(parent_port, cxlmd->dev.parent->parent);
> > +			if (!dport) {
> > +				dev_err(dev, "CXL RCH dport not found\n");
> > +				return -ENXIO;
> > +			}
> > +			rc = devm_cxl_add_endpoint(uport_dev, cxlmd, dport);
> > +			if (rc)
> > +				return rc;
> > +		}
> 
> Still reviewing the patch, but thoughts on moving the two new big blocks to a helper function?
> 
> DJ
> 
> >  	}
> >  
> >  	if (cxlmd->attach) {
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index bace662dc988..710a62a66429 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -708,10 +708,10 @@ static ssize_t rcd_pcie_cap_emit(struct device *dev, u16 offset, char *buf, size
> >  {
> >  	struct cxl_dev_state *cxlds = dev_get_drvdata(dev);
> >  	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> > -	struct device *root_dev;
> >  	struct cxl_dport *dport;
> > +	struct device *root_dev;
> >  	struct cxl_port *root __free(put_cxl_port) =
> > -		cxl_mem_find_port(cxlmd, &dport);
> > +		cxl_mem_find_port(cxlmd, NULL);
> >  
> >  	if (!root)
> >  		return -ENXIO;
> > @@ -720,13 +720,20 @@ static ssize_t rcd_pcie_cap_emit(struct device *dev, u16 offset, char *buf, size
> >  	if (!root_dev)
> >  		return -ENXIO;
> >  
> > -	if (!dport->regs.rcd_pcie_cap)
> > -		return -ENXIO;
> > -
> >  	guard(device)(root_dev);
> >  	if (!root_dev->driver)
> >  		return -ENXIO;
> >  
> > +	/*
> > +	 * Fetch dport under uport_dev lock to protect against concurrent
> > +	 * hotplug removal. uport_dev->mutex is held for the entire devres
> > +	 * teardown sequence including free_dport(), so holding it here
> > +	 * excludes concurrent kfree(dport).
> > +	 */
> > +	dport = cxl_find_dport_by_dev(root, cxlmd->dev.parent->parent);
> > +	if (!dport || !dport->regs.rcd_pcie_cap)
> > +		return -ENXIO;
> > +
> >  	switch (width) {
> >  	case 2:
> >  		return sysfs_emit(buf, "%#x\n",
> 
> 
