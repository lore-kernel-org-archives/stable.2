Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB1446AEEF;
	Wed,  3 Jun 2026 12:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780488347; cv=none; b=qSjswknJt5cZFQ/uBcerbfTj31Q6+6s32OH2ONR3jGSEcYLXe2UgqkBFOmREXpdXZ/t8NiqaebYyAnvNG7bH1293nCMrQNGjVqKWntoWWOsD4Y4NAVNERlUjTkh3C1/YDeDvSnNhMT443ACdOSUJbkrP8L+2zbvu0Qd3Xr+uAlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780488347; c=relaxed/simple;
	bh=bKOsqsyLZB9JwlVf6V5SQTmCqESCGhnbYZZIaw6VDSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PVYnVWk+1w3WdJBltOzlfW9Y0llpdtn4y1jApewIjK4L3qirNwuqDUDIfK4HHtjjdMRkVWfHobuA+2QdjhR1ZBDifNpt/tEWxtqTSC6MuoZIQWTs4um+y6sSex/0u/tI3vicLKfhV8FRNqsUhNLlumKnDjJFGZsd+6a89d4yUvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8hQG6qN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8hQG6qN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C11261F00893;
	Wed,  3 Jun 2026 12:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780488346;
	bh=MM7RRVhqPTlxtMXqTYBOK1SOCNMNrDXSVM/K+K1p8a8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=M8hQG6qNHb2FtS6Sae/SBDvlIBvgHlYZqYB6AKsm1UIxVpiBTbQkJdVTOeuvJnKmZ
	 dOvXnU1M18/DYRL0FaS1GnNvxWMQVzb0t1poISDugfZHMhgW4IffllKTafTlgiOFch
	 5vxs7ML2Y4VSJGAzmSwbSCHO/OWFlQnqSD/4kEicJ/fwmIB4IO3C1AAVc57qWBimtz
	 gcoM3YG5nTPE/JyiDfy/jtwWoWdeM1iHboRxGnli7YzZPYWIXoVsFvtsPYKA+uVbWv
	 Xe9yryB0Q5c8pwecX/95qGTQUQZhRc+MceUAi2kp6LFLYzpUR+pqW4mNkOHoEKuXvh
	 zpy96EZI61jvA==
Date: Wed, 3 Jun 2026 13:05:39 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Chris Gellermann <christian.gellermann@codasip.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, david@kernel.org, 
	liam@infradead.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, mhocko@suse.com, rppt@kernel.org, shuah@kernel.org, 
	surenb@google.com, vbabka@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] selftests/clone3: Fix wild pointer access of
 getline due to missing init
Message-ID: <aiAYQVaVGRLfmpAK@lucifer>
References: <20260526113409.ea65314eb1da831de7c90ca6@linux-foundation.org>
 <20260603104310.936706-1-christian.gellermann@codasip.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603104310.936706-1-christian.gellermann@codasip.com>

Hm you're combining 2 of my least favourite things in one :)

- Doing a >1 patch series with patch N+1 in-reply-to patch N
- Doing a vN+1 in reply to a vN series.

Just for future, please send series independent of each other not in reply to
other series, and if there's more than 1 patch, send a cover letter and have all
the patches reply to that!

Thanks, Lorenzo

On Wed, Jun 03, 2026 at 12:43:09PM +0200, Chris Gellermann wrote:
> Clone3_set_tid uses getline(&line, ...) in a loop to read the child's
> process status. The code expects that getline allocates the buffer for
> the line on the first loop iteration. According to the Open Group
> Spec[1], char *line has to be null pointer for this:
>
> > ssize_t getline(char **restrict lineptr, ...);
> > If *lineptr is a null pointer or if the object pointed to by *lineptr
> > is of insufficient size, an object shall be allocated as if by
> malloc()
> > or the object shall be reallocated as if by realloc()[...].
>
> However, char *line is only declared, leading to an undefined value
> that is potentially non-null. In an example run with Musl v1.2.6, the
> realloc call[2] of getdelim, which implements getline, triggers a
> segfault:
>
> ./run_kselftest.sh --test clone3:clone3_set_tid
> [ 1366.165898] kselftest: Running tests in clone3
> ...
> [ 1367.799244] clone3_set_tid[811]: unhandled signal 11 code 0x1 at
> 0x0000000000000000 in libc.so[68184,3fbf69f000+4c000]
> [ 1367.802808] CPU: 0 UID: 0 PID: 811 Comm: clone3_set_tid Not tainted
> ..
> [ 1367.804188]  epc: 0x0000003fbf6b0184
> [ 1367.804188]  ra : 0x0000003fbf6d4664
> [ 1367.804188]  sp : 0x0000003fce5f2e40
> [ 1367.805314]  gp : 0x0000002aaab0dfb8
> [ 1367.805314]  tp : 0x0000003fbf6f14a8
> [ 1367.805314]  t0 : 0x0000003fbf63d000
> ...
>
> Looking at the realloc implementation, Musl mallocs for a null pointer
> memory. But for a non-null pointer, it assumes it's passed a valid
> pointer to the heap and tries to access its meta-data. This leads to the
> segfault we see:
>
> void *realloc(void *p, size_t n)
> {
>         if (!p) return malloc(n);
>         if (size_overflows(n)) return 0;
>
>         struct meta *g = get_meta(p);
>         ...
> }
>
> Fix this by properly initializing the line pointer to NULL.
>
> [1] https://pubs.opengroup.org/onlinepubs/9799919799/functions/getline.html
> [2] https://git.musl-libc.org/cgit/musl/tree/src/stdio/getdelim.c#n38
>
> Fixes: 41585bbeeef9 ("selftests: add tests for clone3() with *set_tid")
> Cc: stable@vger.kernel.org
> Acked-by: David Hildenbrand (arm) <david@kernel.org>
> Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
> Signed-off-by: Chris Gellermann <christian.gellermann@codasip.com>
> ---
>  tools/testing/selftests/clone3/clone3_set_tid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/clone3/clone3_set_tid.c b/tools/testing/selftests/clone3/clone3_set_tid.c
> index 5c944aee6b41..485efa7c9eed 100644
> --- a/tools/testing/selftests/clone3/clone3_set_tid.c
> +++ b/tools/testing/selftests/clone3/clone3_set_tid.c
> @@ -141,7 +141,7 @@ int main(int argc, char *argv[])
>  {
>  	FILE *f;
>  	char buf;
> -	char *line;
> +	char *line = NULL;
>  	int status;
>  	int ret = -1;
>  	size_t len = 0;
> --
> 2.47.3
>
