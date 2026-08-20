Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D94743B3FD;
	Thu, 20 Aug 2026 15:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787239688; cv=none; b=miWg1j6cl1GZGHZM1Iqa1b5Cer5AxH3BYkzHrIIpNixvUFG7f4M47MbT2nrC9pYV6VgcVTWj//gWYQPZF193oT60yzuDDu/uLSXv1Ay3xggnjiDLtgPLzq9M3v2yIJX7FoiKcOORG3uE2ZwcDoPTJ4JYcvnvvqts84P4fB+8kGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787239688; c=relaxed/simple;
	bh=O5zDUPDSE66TRU0zbrIrzGmq5vANQQTCa+jLG1djmuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJU3RJy2n1JuWH+QJio+ctPMp5b2VxieLSI90ZtZseMFI8e5sCc6D8HPWfcb0Cqdszj2Za7Qfhvc86ytzQ4s62qZEoeAT4qrfTGQzzBeE5kMcK+3C3q/Ed73SBJ8IJbdX8kOenuDyUBPvmamY08zvSFDM7gRrs5BSpKwUxrRbps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lza45wcw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lza45wcw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996751F00A3D;
	Thu, 20 Aug 2026 15:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787239686;
	bh=O5zDUPDSE66TRU0zbrIrzGmq5vANQQTCa+jLG1djmuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Lza45wcwb3xbN3uoPjefPmzjfFIo0y3tcdwBlvp9X2AoGwfWvDmT46aEVafY9+sYU
	 Kg5Fy+SEPS6dKQuft/wGi92qKZy1+4x3OjKgIY9E0bq5Nlg3TuSglL5aTWwSE4u7/9
	 ubKG9a/DYzycH/FrbKkKh5izDJE1eBYQ2KZGRS4M4ZcRmpuahSYwqcmLXu7+gLfDYm
	 zE6Zb1D9ydgG98u7xhpqjrxuCF7UfS969bh+Wex3kzx1iodj8SCcOV7AxvUxaATRrz
	 982ira5Yp1pOEMe/L2C23JgkIHv5gQnKWtOgwMQQHJBuyDTX3Edz9bqX5eRkofkXdT
	 9IBp10kep+blw==
Date: Thu, 20 Aug 2026 16:28:02 +0100
From: Simon Horman <horms@kernel.org>
To: Zihan Xi <zihanx@nebusec.ai>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, bhong@brocade.com,
	stephen@networkplumber.org, sven@brocade.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Vega <vega@nebusec.ai>
Subject: Re: [PATCH net 1/1] net: l2tp: ignore multicast notification errors
 in netlink commands
Message-ID: <20260820152802.GZ265046@horms.kernel.org>
References: <cover.1786962220.git.zihanx@nebusec.ai>
 <e9cf566687c906ba6843f72b28f11a3431a595b5.1786962220.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9cf566687c906ba6843f72b28f11a3431a595b5.1786962220.git.zihanx@nebusec.ai>

On Mon, Aug 17, 2026 at 05:21:09PM +0000, Zihan Xi wrote:
> l2tp_nl_cmd_tunnel_create(), l2tp_nl_cmd_session_create(), and
> l2tp_nl_cmd_session_modify() update live state before sending their
> multicast notifications. A notification helper can fail while allocating
> or encoding the message, or while multicasting it. Returning any such
> best-effort notification error after the state change makes a successful
> command look like a failure and can cause retries to accumulate live
> objects.

Is this a theoretical problem, or something that has been observed?

> Keep sending notifications for listener visibility, but do not let their
> best-effort status overwrite the command result. The explicit (void) casts
> make this intentional for all notification helper failures.

I don't think the (void) cast is in keeping with the existing code
in this file.

> Fixes: 33f72e6f0c67 ("l2tp : multicast notification to the registered listeners")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Zihan Xi <zihanx@nebusec.ai>

I am wondering if you considered extending this patch to
also cover l2tp_nl_cmd_tunnel_modify().

...
