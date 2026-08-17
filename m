Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F373F1AA1;
	Mon, 17 Aug 2026 15:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786982199; cv=none; b=N38Erc0mov7cSDBECTArhtYB9Q+3WKyATvm4/hdda+7hgStQeBoSqRTq8DNmCAY3drth1ltZW1JCLOAM52s+b9uxlA/ZSsSxhdK4PL9lDvQ2cUd0qiZzdBK7BPRdaHVJbFk3n/ULqIebPweIftnd5PugBlWzDOIxq4wBsRYvSTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786982199; c=relaxed/simple;
	bh=GTEsANk54wl/XGobmIXxhwFPZjdwv7Xswwym6rG0W00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=asmtKfl7ydZrwP7/+JwIrpEyTV5K/YQFCT+5YB9/aGzpEwjwmkSL03G509ONrp5Sc4+jlX1FWcKUbjT8ySp2wMfkKV9K65gcb1blH94M8ZVIXx4xrrAPJ/723IGx5mkElL0SsNpBEzW4uNwYZ+gx/dMwzX7MHw/Wdr2vFkR6ULU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=h02nLnMd; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="h02nLnMd"
Received: from ideasonboard.com (unknown [IPv6:2001:b07:6462:5de2:520d:d7a3:63ca:99e8])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 287C5E4E;
	Mon, 17 Aug 2026 17:55:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1786982115;
	bh=GTEsANk54wl/XGobmIXxhwFPZjdwv7Xswwym6rG0W00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h02nLnMdLRXfIC5QeQDxntWBYd3acYVG1EZ8cmwAyQfG3i/G2K2ffq5goqL3R9kvy
	 lCr074CxUOH9UqvKY1bXytzCJ64nz0OYf9avC3OOWfeqOSOsvhscpiUXeEiDf0/7tk
	 VansDdgavXNVEY7Rb3QBa1kghOvRs3PaghkUQRPk=
Date: Mon, 17 Aug 2026 17:56:30 +0200
From: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To: David CARLIER <devnexen@gmail.com>
Cc: Jacopo Mondi <jacopo.mondi@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Michael Riesch <michael.riesch@collabora.com>, 
	Daniel Scally <dan.scally@ideasonboard.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
	Hans Verkuil <hverkuil+cisco@kernel.org>, stable@vger.kernel.org, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: v4l2-isp: reject zero-sized parameter blocks
Message-ID: <aoMuMvE0zJG1MYD2@zed>
References: <20260815193839.141406-1-devnexen@gmail.com>
 <aoLZ5e0ffVvZ-FfB@zed>
 <CA+XhMqxR+m7Jt0UUHetCfXSHHtW5w-jUc0_PSSWjTbprYn8ZwQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+XhMqxR+m7Jt0UUHetCfXSHHtW5w-jUc0_PSSWjTbprYn8ZwQ@mail.gmail.com>

Hi David

On Mon, Aug 17, 2026 at 02:40:53PM +0100, David CARLIER wrote:
> Hi Jacopo,
>
> On Mon, Aug 17, 2026 at 11:59:15AM +0200, Jacopo Mondi wrote:
> > > whenever the driver's type_info[] entry is an uninitialised hole, so
> >
> > This shouldn't happen (an empty type_info[] I mean)
> [...]
> > > held. rppx1 has such a hole today; fix the core so the walk terminates
> >
> > Uh, where ?
>
> Sorry, I should have spelled this out in the commit message.
>
> RPPX1_PARAMS_BLOCK_INFO() is a designated initialiser indexed by the
> block type (rpp_params.c:13):
>
>       #define RPPX1_PARAMS_BLOCK_INFO(block, data) \
>               [RPPX1_PARAMS_BLOCK_TYPE_ ## block] = { \
>                       .size = sizeof(struct rppx1_ ## data ## _params), \
>               }
>
> so the list reads as dense but is indexed by the enum. It has 17

Upsie, you're right, I didn't properly consider that..


> entries for 18 enumerators, and the missing one is AWBG_POST (== 3).
> The last index used is LIN_PRE2 (== 17), so ARRAY_SIZE() is still 18
> and the entry at 3 is simply zeroed.
>
> A block with type AWBG_POST and size 0 then gets through: 0 is not
> larger than the remaining buffer, and block->size != info->size is
> 0 != 0. block_offset and buffer_size don't move and the loop spins,
> in .buf_prepare, holding the queue mutex.
>
> > I'm not against this, but it only makes sense if the driver populates
> > the list of v4l2_isp_params_block_type_info[] with an empty item,
> > which shouldn't happen.
>
> True, and rppx1 is the only one that does - rkisp1, c3-isp and
> mali-c55 all look complete. What bothers me is that the loop only
> terminates if every driver's table is right, and nothing checks that
> at build time. A missing line in a driver would be a rejected buffer

Right.

Should we instead deman that all entries provided by the driver are
populated by failing validation if info->size == 0 ?

> rather than a stuck task. And a block size below its own header is
> malformed anyway, whatever the type.
>
> That said, rppx1 needs a patch either way: AWBG_POST is documented i
> rppx1-config.h and the driver probes rpp->post.awbg, but the block
> can't be used today - the size check compares against 0, and
> rppx1_params() has no case for it in the switch.

Right.. you might have seen ?
https://patchwork.linuxtv.org/project/linux-media/list/?series=29170

In any case, yes, I think we should populate all entries and either
require all info blocks to be valid (hence a 0 sized block from
userspace is refused) or explicitly check if block->size > 0
as you're doing here.


>
> Happy to drop a separate patch and keep only the driver fix if you prefer.
>
> Cheers.
