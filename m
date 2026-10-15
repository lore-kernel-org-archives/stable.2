Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112DE2459CF;
	Thu, 15 Oct 2026 19:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792092640; cv=none; b=ew8TqTrGSy20SyJzdaoMNHCLjXYZ91+j99xOElhHMktS1+ipCZX/b8tv7qMZOd7M4qRXbVHMliSFB17WrRHwQJ8WNDOGTbDOQ4UQTkfOFxRNMeRbvoLT5AkrZik+YaqI2fCaJr8chWRhUOUoYQyQqagqbENoGIlxdlu/yZZG8QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792092640; c=relaxed/simple;
	bh=qBPtAvglUjCZGleelOkOOqqmiQKkLs1LZ7i6JWqjLtQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mQWhsyQD/WW8j/KgdMBZUoLDLuh19riRxsv+IQCD758Qkx5sypVKhU225efUka1NkgrrIoyx2Y8M65zYx9YMKsiFhh1YLIGNtXvTnv3RrDv7ovBdixi5UrZP1HruVxfH42EjgRYC3FIc6SYg8f26wdxqylN84Q0miLgEq8/ts3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8xFBqc+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8xFBqc+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A9521F000C5;
	Thu, 15 Oct 2026 19:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792092637;
	bh=Zc3mBX2CmFvaIP5sKLJr+jv/V4h90b405bhZT8Iypw4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=N8xFBqc+AmWl0y9SPkSvRoZatPCZKBWvZ03bZsWm/tqB/uCADyjF2HWF/gxzhWOxs
	 WOvIGg+srKlR/1Fs2gB8MvIbfXujfCXoKKFwdVJUX8uQv1CB1/898RTrkcRn6dlvLY
	 UBNP3QsFDaK6REk/rAfRjSkiaC5mF06NXlXfFIH99T/ncaJ6nL+PcCIu+lYHTM3vBO
	 F3QT6NoQMUajpSkFe0ci4zElVqQsZnkjDje3e0OikGKohXykAjxPyAGmFtJNHpL35N
	 JVDcL0IE7YT7rIgF9OYkR8SNWlyX0T1cTKNT2uLTDSpLSc8I5ChXU7UwuOfLyNVkQk
	 p0N2e/6HiLNnQ==
Subject: Re: [PATCH] net/sched: cls_api: skip indr register on failed bind
From: netdev-bot+sashiko@kernel.org
To: q.h.hack.winter@gmail.com
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, elic@nvidia.com, stable@vger.kernel.org
Date: Thu, 15 Oct 2026 19:30:36 +0000
Message-ID: <179209263675.434549.1993653089289586887@kernel.org>
In-Reply-To: <20261013163014.25722-1-q.h.hack.winter@gmail.com>
References: <20261013163014.25722-1-q.h.hack.winter@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch does not fully close the failed-bind leak.

--

net/sched: cls_api: skip indr register on failed bind

This patch adds an early -EOPNOTSUPP return to tcf_block_offload_cmd().
It fires for FLOW_BLOCK_BIND on a device without ndo_setup_tc() when the
block already has offloaded filters. The aim is to stop a failed bind
from leaving a record on flow_indir_dev_list, which later causes a
use-after-free of the freed tcf_block.

> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> index a9f54988561f2..7acfe71853a7c 100644
> --- a/net/sched/cls_api.c
> +++ b/net/sched/cls_api.c
> @@ -860,6 +860,10 @@ static int tcf_block_offload_cmd(struct tcf_block *block,
>  		return tcf_block_setup(block, &bo);
>  	}
>  
> +	/* a bind that cannot succeed must not leave a record behind */
> +	if (command == FLOW_BLOCK_BIND && tcf_block_offload_in_use(block))
> +		return -EOPNOTSUPP;
> +
>  	flow_indr_dev_setup_offload(dev, sch, TC_SETUP_BLOCK, block, &bo,
>  				    tc_block_indr_cleanup);
>  	tcf_block_setup(block, &bo);

[Severity: High]
Is offloadcnt read too early here to fully close the leak?

The real rejection in tcf_block_offload_bind() reads offloadcnt after
flow_indr_dev_setup_offload() and tcf_block_setup() have run:

net/sched/cls_api.c:tcf_block_offload_bind() {
    ...
no_offload_dev_inc:
	if (tcf_block_offload_in_use(block))
		goto err_unlock;
    ...
}

Between the two reads, tcf_block_setup()->tcf_block_bind() replays the
existing filters to each newly allocated indirect block_cb:

tcf_block_bind()
  tcf_block_playback_offloads()
    tp->ops->reoffload()   (e.g. fl_reoffload())
      tc_setup_cb_reoffload()
        tc_cls_offload_cnt_update(add = true)
          tcf_block_offload_inc()

If the indirect driver accepts any replayed filter, offloadcnt goes
from 0 to non-zero. tcf_block_bind() then publishes the callback:

	list_splice(&bo->cb_list, &block->flow_block.cb_list);

The indirect branch still always returns -EOPNOTSUPP. So
tcf_block_offload_bind() sees tcf_block_offload_in_use() as true and
fails the bind. tcf_block_get_ext() then goes to err_block_offload_bind
without calling tcf_block_offload_unbind().

Does that still leave two things behind?

First, the indir_dev_add() record stays on flow_indir_dev_list, with
data = block and cb_list = &block->flow_block.cb_list.

Second, the indirect flow_block_cb stays on flow_block_indr_list with
indr.data = block. This second leak happens even when indir_dev_add()
returned -EEXIST.

After the block is freed, flow_indr_dev_register()->
existing_qdiscs_register() would list_splice() into the freed block's
cb_list. Also, flow_indr_dev_unregister()->tc_block_indr_cleanup() would
dereference the freed block through block_cb->indr.data. These are the
same two use-after-free paths the commit message describes.

Here is one way to reach it:

- an indirect tunnel offload driver is registered
- a shared block has flower filters (no skip_sw) that nothing has
  offloaded yet, so offloadcnt == 0
- a tunnel device without ndo_setup_tc(), such as vxlan, is bound to
  the block
- the indirect driver accepts at least one replayed filter

The commit message also describes the new predicate as:

  "the condition tcf_block_offload_bind() rejects the bind with"

Is that accurate? The actual rejection uses the offloadcnt value from
after the replay.

Would it be more robust to roll back on the failing path in
tcf_block_offload_bind() instead of predicting the post-bind offloadcnt
in advance? That could mean issuing a FLOW_BLOCK_UNBIND, or removing the
record and unbinding the spliced callbacks.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013163014.25722-1-q.h.hack.winter%40gmail.com
