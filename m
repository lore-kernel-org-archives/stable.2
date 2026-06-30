Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAC92E739D;
	Tue, 30 Jun 2026 23:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782861975; cv=none; b=BAgi6ZOoRpH2NFIa7oH2RaqXTDfxmUKv0hrFIUEXrAxvuoZ+7kSn453xdCZI3zQ651RYYJo8ed2ODbNaGh42TYYC3+ubuFPC9wv5eO3SI+tIg/UxPNJxuxoJEelPqgGEjZ0xZ/UOErUoN0UMp5Z54AmxVRRDlix05g+Gngx74Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782861975; c=relaxed/simple;
	bh=9vGalAOsLPcJUq7KMLEtC4VkqUsqCi3zY6br5fZ9gsY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=McxMU9Ne+GM75VNAzEOeAPYeV8xdEcXBvVIP6rstr9mriXYG8LbUxHM/msRIAp8w8vFtWkqyK5viT/LFr5qe+/5LC/cZEYrRJEn9PPb4we1RBs5onyr4lpk81keyA2BmTfN9f8a9kCq1S6Hz8MKkkbHHbl4Y2PF44Ata/g1H93o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibuSdTQV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibuSdTQV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA7AC1F000E9;
	Tue, 30 Jun 2026 23:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782861974;
	bh=UjhfWxTf1PrShdtV9sLZkODcbJd9iyF248wEEnzzhj0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ibuSdTQVWk7cvzki6/7/Swjg81STECAO7y1ETLLCTy3OFpEC7Ee0yUCUujgFv8P1s
	 L3q1OC+dx3cN1Bf5aOy3ogR3Ma1RDSfXZbDIAWssLtcybvL77SI7kIdmZwMW5oeRkw
	 kvuXq+D7y0cg0X+lfv+/RGfiEz9KpgHCZ25HivTCp4RHcC5uAq7p7rrro05SXO6kCw
	 DM6/OvYDXevD8bp+67zf1DAkYgRQJ1AlJganrICYf+ft6Ub0OsPIMA4mjecUc3a5bM
	 UfpzN0naSzEJ2HpO//B+k/TU369v40wmqIdmLDqqDItbhK+3N0OvVwHolZHGee8XbD
	 5rrqUOdvlJbbQ==
Date: Wed, 1 Jul 2026 08:26:11 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Bradley Morgan <include@grrlz.net>, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] lib/bootconfig: fix undefined behavior involving
 NULL pointer arithmetic
Message-Id: <20260701082611.6575e0f37541014f67830bdc@kernel.org>
In-Reply-To: <20260701075843.a308d7dadf327eda4015236b@kernel.org>
References: <20260630174746.14795-1-include@grrlz.net>
	<20260701075843.a308d7dadf327eda4015236b@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 1 Jul 2026 07:58:43 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Tue, 30 Jun 2026 17:47:46 +0000
> Bradley Morgan <include@grrlz.net> wrote:
> 
> > When xbc_snprint_cmdline() is called during the size-probing phase
> > (with buf = NULL and size = 0), the function computes the end pointer
> > as 'buf + size' (NULL + 0) and repeatedly advances 'buf' via 'buf += ret'.
> > 
> > Under the C standard, performing pointer arithmetic on a NULL pointer is
> > undefined behavior. While harmless inside the kernel, this code is also
> > compiled into the userspace host tool 'tools/bootconfig', where host
> > compilers with UBSan or FORTIFY_SOURCE enabled abort the build when they
> > detect NULL pointer arithmetic.
> > 
> > Fix this by guarding the pointer arithmetic so 'buf' is only advanced when
> > non-NULL, and track the running written length in a separate 'len' counter
> > for the return value (which cannot be recovered from pointer math when
> > 'buf' is NULL). The rest() helper and snprintf call sites are unchanged.
> > 
> > Fixes: 51887d03aca1 ("bootconfig: init: Allow admin to use bootconfig for kernel command line")
> > Cc: stable@vger.kernel.org
> > Assisted-by: GLM:glm-5.2
> > Signed-off-by: Bradley Morgan <include@grrlz.net>
> 
> Thanks for the fix!
> Let me pick this to bootconfig/fixes.

Sorry, I eventually decided to pick Breno's fix [1], because it fixes
the same issue earlier (in bootconfig/core) and has a well documented
comment on the code.

[1] https://lore.kernel.org/all/20260626-bootconfig_using_tools-v7-1-24ab72139c29@debian.org/

BTW, I decided to have several branches for bootconfig and probes.

bootconfig/core is a core development branch, which is the main branch.
The patches in this branch is for development, including new features
and fixes. (but fixes will be moved to */fixes soon.)

bootconfig/fixes is for a branch to manage fixes. This will be sent to
Linus soon (for urgent fix), or after releasing -rc.

bootconfig/for-next is for new features or cleanups, for preparing the
next merge window, and for merge test in linux-next.

If you make any patches, please check the bootconfig/core at first,
and check bootconfig/fixes for fix.

Note: The core is usually forcibly updated, actively rebased on top of
bootconfig/fixes. The for-next is not so frequently updated, but can
be forced update for fixing merge conflict etc. The fixes should be
solid, but if I made mistakes I will forcibly update it before sending
PR.

Thank you,

> 
> Thank you,
> 
> > ---
> >  lib/bootconfig.c | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> > 
> > Changes since v1:
> > - Got the big guns out! :) (see Assisted-by).
> > - Addressed review from Masami Hiramatsu and Breno Leitao.
> > 
> > diff --git a/lib/bootconfig.c b/lib/bootconfig.c
> > index f445b7703fdd..c913259c80ce 100644
> > --- a/lib/bootconfig.c
> > +++ b/lib/bootconfig.c
> > @@ -427,8 +427,9 @@ static char xbc_namebuf[XBC_KEYLEN_MAX] __initdata;
> >  int __init xbc_snprint_cmdline(char *buf, size_t size, struct xbc_node *root)
> >  {
> >  	struct xbc_node *knode, *vnode;
> > -	char *end = buf + size;
> > +	char *end = buf ? buf + size : NULL;
> >  	const char *val, *q;
> > +	size_t len = 0;
> >  	int ret;
> >  
> >  	xbc_node_for_each_key_value(root, knode, val) {
> > @@ -442,7 +443,9 @@ int __init xbc_snprint_cmdline(char *buf, size_t size, struct xbc_node *root)
> >  			ret = snprintf(buf, rest(buf, end), "%s ", xbc_namebuf);
> >  			if (ret < 0)
> >  				return ret;
> > -			buf += ret;
> > +			len += ret;
> > +			if (buf)
> > +				buf += ret;
> >  			continue;
> >  		}
> >  		xbc_array_for_each_value(vnode, val) {
> > @@ -456,11 +459,13 @@ int __init xbc_snprint_cmdline(char *buf, size_t size, struct xbc_node *root)
> >  				       xbc_namebuf, q, val, q);
> >  			if (ret < 0)
> >  				return ret;
> > -			buf += ret;
> > +			len += ret;
> > +			if (buf)
> > +				buf += ret;
> >  		}
> >  	}
> >  
> > -	return buf - (end - size);
> > +	return len;
> >  }
> >  #undef rest
> >  
> > -- 
> > 2.53.0
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
