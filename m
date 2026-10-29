Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=83.166.143.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793273855;
	b=GT14G37YkbNQfbOM8/N/pTU80b04EboIESm0srvQYKFllSVRXg8DGHh8MZDESZTBC5g2
	 E4DuTDm81F64p6E60ukLCbYLgpGFe24qqaTfSpIQ90ezVU/T3KAeFceupuay3YaAeDb8D
	 oVAhLL32CpeON7CwrE8Da/hjHcDVvHIMirqmPENYLjAeCEcgqH3x7PnlEruZsCzFlNQvg
	 4z61raws1GibP4v7nAvoiSYyhJw5PrF8T7JDtqfI4taOVrXOdM6a0iUVD/GkhVEGTk/z1
	 DGytgitv02qMnNl16r8UfnTG64L8k+RTxzuPvg1GuSqsrDe9c/MOsiDQShU7SjU68XQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793273855;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Infomaniak-Routing;
	bh=eHfZE4PHAumKVw00FNrKGZ/KoE0eh/vNsiLYomKpEgw=;
	b=2yf6xPaK0rWF7joBx8M40CJUJWDv/5Mh39UfnV93PWyb2j8ThMgbMBf63tXSmjLy6n95
	 BlzUKeOgPHXsGbI40rtg+AXU5pDfMxiT3eLDf1BPsKGvjka5NWWoKsGD+bIhsQVTG06eH
	 6Z2uF84Q89Q24MzOfKQ+v7opTArCq/lzDwPdjwdhcuLHrUc/KUOQFzGYotSo9Z6Kn+wvm
	 JkBTRR7knDCYSdA3kXElHHiKggVPtfP5GHF4ekYLdiS72JyoqiRR2XKxJzBSWr9f8aV5u
	 LOG/zgLvWBiB22hnZkG0f6UWbGlrG+RBymkRE2uPvaYyIpwbdLUVpObO3EC7Jk+rbJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=qws1AYFs;
	arc=none smtp.remote-ip=83.166.143.172
Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch [83.166.143.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A36606A31C
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 11:37:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00A36606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=qws1AYFs
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jFhzR5rnlzZq;
	Thu, 29 Oct 2026 12:37:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1793273843;
	bh=eHfZE4PHAumKVw00FNrKGZ/KoE0eh/vNsiLYomKpEgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qws1AYFsJRAFrEibfRJMw6vRg1RddQFeLYZXo/dFV6qTtr2iUnKM1pIjCmJI4kda4
	 Gha+sg06kqltmryQZ2HwEdjmuONSjezZzJeiopU5f/fR0VmNz8XuWMCnJVE9r6yPtN
	 yqjz5rjdDMl5FG1E3bZQddWAqWSkmZBEuia7KoAE=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4jFhzQ1yLXzGM3;
	Thu, 29 Oct 2026 12:37:22 +0100 (CET)
Date: Thu, 29 Oct 2026 12:37:20 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Serge Hallyn <serge@hallyn.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, Jann Horn <jannh@google.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] userns: don't drop the exec securebits
Message-ID: <20261029.Yae2Nohsheun@digikod.net>
References: <20261026-work-securebits-userns-v1-0-b35473fa1a34@kernel.org>
 <20261026-work-securebits-userns-v1-1-b35473fa1a34@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261026-work-securebits-userns-v1-1-b35473fa1a34@kernel.org>
X-Infomaniak-Routing: alpha

On Mon, Oct 26, 2026 at 09:53:29PM +0100, Christian Brauner wrote:
> SECBIT_EXEC_RESTRICT_FILE and SECBIT_EXEC_DENY_INTERACTIVE tell script
> interpreters to only run what AT_EXECVE_CHECK allows and to refuse
> interactive input. A service manager sets them together with their lock
> bits so that nothing below it can turn them off again.
> 
> But set_cred_user_ns() resets all securebits to SECUREBITS_DEFAULT. So
> any task that can create a user namespace sheds the locked exec bits
> with a single unshare(CLONE_NEWUSER) and joining one with setns() does
> the same. The lock is pointless if anyone who may create a user
> namespace can drop it, and that is pretty much everyone.
> 
> Resetting the other bits is fine. They are about how capabilities are
> computed and a new user namespace starts out with a full set of
> capabilities anyway. The exec bits grant nothing though. They are
> restrictions a task placed on itself, just like no_new_privs which a
> user namespace doesn't touch either. So keep them and their locks.
> 
> Reproducer:
> 
>   // SPDX-License-Identifier: GPL-2.0
>   /* Lock the exec securebits, then create a user namespace and look at them again. */
>   #define _GNU_SOURCE
>   #include <sched.h>
>   #include <stdio.h>
>   #include <sys/prctl.h>
> 
>   #define SECBIT_EXEC_RESTRICT_FILE		(1 << 8)
>   #define SECBIT_EXEC_RESTRICT_FILE_LOCKED	(1 << 9)
>   #define SECBIT_EXEC_DENY_INTERACTIVE		(1 << 10)
>   #define SECBIT_EXEC_DENY_INTERACTIVE_LOCKED	(1 << 11)
> 
>   int main(void)
>   {
>   	int bits = SECBIT_EXEC_RESTRICT_FILE | SECBIT_EXEC_RESTRICT_FILE_LOCKED |
>   		   SECBIT_EXEC_DENY_INTERACTIVE | SECBIT_EXEC_DENY_INTERACTIVE_LOCKED;
> 
>   	if (prctl(PR_SET_SECUREBITS, bits, 0, 0, 0)) {
>   		perror("PR_SET_SECUREBITS");
>   		return 1;
>   	}
>   	printf("before: 0x%x\n", prctl(PR_GET_SECUREBITS, 0, 0, 0, 0));
>   	printf("clear locked bits: %s\n", prctl(PR_SET_SECUREBITS, 0, 0, 0, 0) ? "refused" : "ALLOWED");
> 
>   	if (unshare(CLONE_NEWUSER)) {
>   		perror("unshare(CLONE_NEWUSER)");
>   		return 1;
>   	}
>   	printf("after unshare(CLONE_NEWUSER): 0x%x\n", prctl(PR_GET_SECUREBITS, 0, 0, 0, 0));
>   	return 0;
>   }
> 
> On v7.1 this prints "before: 0xf00", "clear locked bits: refused" and
> "after unshare(CLONE_NEWUSER): 0x0". With this patch the last line
> reads 0xf00 as well.
> 
> Fixes: a0623b2a1d59 ("security: Add EXEC_RESTRICT_FILE and EXEC_DENY_INTERACTIVE securebits")
> Cc: stable@vger.kernel.org # v6.14+
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Thanks!

Reviewed-by: Mickaël Salaün <mic@digikod.net>

> ---
>  Documentation/userspace-api/check_exec.rst | 4 ++++
>  kernel/user_namespace.c                    | 5 ++++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/userspace-api/check_exec.rst b/Documentation/userspace-api/check_exec.rst
> index 05dfe3b56f71..0904810e1d8d 100644
> --- a/Documentation/userspace-api/check_exec.rst
> +++ b/Documentation/userspace-api/check_exec.rst
> @@ -99,6 +99,10 @@ This secure bit may be set by user session managers, service managers,
>  container runtimes, sandboxer tools...  Except for test environments, the
>  related ``SECBIT_EXEC_DENY_INTERACTIVE_LOCKED`` bit should also be set.
>  
> +Both secure bits and their locks are inherited across :manpage:`fork(2)` and
> +:manpage:`execve(2)`, and they are kept when a task creates or joins a user
> +namespace.
> +
>  Here is the expected behavior for a script interpreter according to combination
>  of any exec securebits:
>  
> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index 50c374ed4687..cd748e1cbace 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -46,8 +46,11 @@ static void set_cred_user_ns(struct cred *cred, struct user_namespace *user_ns)
>  {
>  	/* Start with the same capabilities as init but useless for doing
>  	 * anything as the capabilities are bound to the new user namespace.
> +	 * The exec securebits grant nothing, they are restrictions the task
> +	 * placed on itself. Keep them and their locks.
>  	 */
> -	cred->securebits = SECUREBITS_DEFAULT;
> +	cred->securebits = SECUREBITS_DEFAULT |
> +		(cred->securebits & (SECURE_ALL_UNPRIVILEGED | SECURE_ALL_UNPRIVILEGED << 1));
>  	cred->cap_inheritable = CAP_EMPTY_SET;
>  	cred->cap_permitted = CAP_FULL_SET;
>  	cred->cap_effective = CAP_FULL_SET;
> 
> -- 
> 2.53.0
> 
