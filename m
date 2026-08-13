Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2909728315D;
	Thu, 13 Aug 2026 14:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786632387; cv=none; b=TjPCI6tVEX/KzszWIAMGz2tIaGrdagAsOD/GJN40xT+fQurxUM+dVfE2LDu5+wlqWJNSJq+9iE8/mOEoD032p+M40UT2G1ocTDG+1eViCOhaVYwGDnIv+SaaZXZFF5XwTKw4G17//KFcimjOpfFE0RfpZV2uluR4crrRkcwsESk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786632387; c=relaxed/simple;
	bh=viShXPox1K+/HBOaCT5lwo//Bqpfy0LFLQwBQIoaHYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GR54vqK+2DBx9I6mqp3eEOfzVLil6N5l5CykhWR7nPhVbMUvL2urwj8oj6Y8Xamwi4Jv5gptIWGx/YuVqm6oIwCOGtnc0BoWH5b6l1upI5VAZ0JMszjgz9gbKw/VHmAk1QQRl3Q9bbU5pUOz3tp4Ue9tp0OT/7z19R0XFR7uGQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=MlDgBiMY; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="MlDgBiMY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tARmPlF+6v7USd2QKdPNMQXKZUo05AnDKb3pnb3gJys=; b=MlDgBiMYxHlAVdLimsb7Nem/f3
	9plI+c/WkXG2vBLxtmukqVHWUSxWttXgIzj2jOqFnzBx9Co/L4RELVB/bm/1X+2VjB3mdPOMKymRa
	lv2OqJ04Ft00iWIXAaJ7vEu7PtDdHMn31pvWg21gRvVofKf6qUD1iDWegnv+ZaxDYvx68rFBI6xNh
	bfTaoDAqkDJDTsmI6YgVIPl7IrtzoWJVtJnzTTkQFzwNuATg2sEZFkk7TRXosEQeTDlKGdbYajBNz
	pHbyIdrX6XyZ1l66R5fZrTTBsCuiPyvHEpB4JkXrOdhuAC4IJGduUtEMGGp92JkEsztq474W18Hxh
	EsDxd9pg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wuWhB-005BPt-26;
	Thu, 13 Aug 2026 14:46:13 +0000
Date: Thu, 13 Aug 2026 07:46:08 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Laight <david.laight.linux@gmail.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org, 
	Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net 1/2] ipv4: mcast: getsockopt: do not overwrite past
 optlen
Message-ID: <anxqRqlFXsoc1wwc@gmail.com>
References: <20260806-mcast_fix-v1-0-bed0a5518e57@debian.org>
 <20260806-mcast_fix-v1-1-bed0a5518e57@debian.org>
 <20260807174402.2dfc12d6@pumpkin>
 <anm9gImFEz6EkUZ9@gmail.com>
 <20260810222159.409357fa@pumpkin>
 <ansQ8gHcKdS_Q_ji@gmail.com>
 <20260811081543.26d18828@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811081543.26d18828@kernel.org>
X-Debian-User: leitao

Hello Jakub,

On Tue, Aug 11, 2026 at 08:15:43AM -0700, Jakub Kicinski wrote:
> On Tue, 11 Aug 2026 05:19:17 -0700 Breno Leitao wrote:
> > So my question to you: can you point me to actual software that
> > passes a "small" optlen and expects the kernel to write past it? That
> > would help to decide about the two options above.
> 
> If you are very confident that no such SW exists - we can try to queue
> this up for -next. (TBH I'm not, mcast specifically may be full of
> strange one off manually written user space (as opposed to common libraries)).

> If we decide to change the behavior- we will probably have to wait
> until this makes it to an LTS release + some time for people to deploy.
> It can't be a fix.
> 
> So practically speaking it may be more expedient to add some hacks to
> cater to this case in the conversion, and then remove the hack. That'd
> be easier to revert if someone pipes up later that we broke their SW.

Thanks. I was mostly trying to find out whether this is a real problem
before creating this quirk, and your intuition is helpful here. I will
proceed with the quirk then.

For the sockopt_t conversion I can expand the iterator mid-air for the
few options that size their reply from a count in the header, so the
conversion stays a no-op for userspace.

Expanding is only safe for a user buffer, though - a kernel-backed
optval might be too risky, I would say. And it will not break anything,
given we don't have in-kernel users for this yet (given the __user
params)


I might come up with a helper like this one:
        static inline void sockopt_expand_out(sockopt_t *opt, size_t len)
        {
                if (len < iov_iter_count(&opt->iter_out))
			// No quirk required
			return;
			
                /* Only a user buffer can be larger than the caller
                 * declared; a kernel-backed optval has nothing behind it.
                 */
                if (WARN_ON_ONCE(!iter_is_ubuf(&opt->iter_out)))
                        return;

		iov_iter_reexpand(&opt->iter_out, len);
        }

and then, at the call site, right after the header is read and before
anything is written back:

        /* The reply is sized by gf_numsrc, not by optlen, which only has
         * to cover the fixed header. Grow the output iterator to what the
         * header declares, or the source list gets truncated.
         */
        sockopt_expand_out(opt, size_add(size0,
                                         size_mul(gsf.gf_numsrc,
                                                  sizeof(gsf.gf_slist_flex[0]))));


(All completely untested so far.)

Thanks for the suggestion,
--breno

