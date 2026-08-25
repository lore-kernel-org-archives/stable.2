Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928173B52E6;
	Tue, 25 Aug 2026 19:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787686614; cv=none; b=X8clxTU7gCxvTqcqQmUMq/Aj4GtiE8CK3IXh1leDzelMhrVWc2HegXz9X+tx45ZPXrW7tKsacjd9u/zTcDiVdJw+ephXsF3cIub2lGUD9S422Zuw9LmDrWyluKBPXIMUEC/yIPCXBs0FdttvDrowJpV+2A2SL1/QNZuHo+iMEBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787686614; c=relaxed/simple;
	bh=nl1Voq/J//VAadBIzVwBUdkbrKJ7nVVv9SIZe3O5CPg=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=FeGzvHft75hCzEiVnIN5L7HqEPquzVUsmDpuqx5TYWh5xYxuRr+wp7wIxUQ25GJMpGmeTPfnV0p9NkzcZC7RZGDm/5mLpB4p83WBrtOT/YruOKCPm63m02PeuMRFi+vw9WAfj0jAtnU7Ao13t98BqWZ/oeJ7AkeFHsfdFVzXDWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=gk/pUe3r; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=tjux6oCN; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="gk/pUe3r";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="tjux6oCN"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1787686591; bh=UDqbk4dAPAmJ41YJGuqFT1d
	QSaOULYwQFKUfjUAGj9w=; b=gk/pUe3rOTpBgj9AflUAUtUQTKQnIQOzjbCuW/YTeTtg96ppSL
	rT9hDOjAE+Q4Af5lEfCvtfxcu36iK0ANPKbYkC8iIedZQjvaTsXHEu9xt2FBART3hZUebtJO3fr
	0h7IHpVK8ZRGK8nZ7IOFypFnsGoWvYIdOrC5mvDUFVRNLECTZS1UpX6MtnqcSe/saTavQExKKYQ
	gM0Y4XWHLYJAFcF6x1DDZKF2y09IMeK/6XC2/mt5iuuCEdE5rSxk6T7yDFZZmsiuN0MpOYgPpqg
	Mh+hLbmZoVHrIRAkTpPUH1CIfybcvkLJRrkNdM9uFUPAfW30+G1MlKDhxLVa9WAxrcA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1787686591; bh=UDqbk4dAPAmJ41YJGuqFT1d
	QSaOULYwQFKUfjUAGj9w=; b=tjux6oCNoD3TTrLgh/LB4M9972WtmCiUoSifY6HJZnk9pL/R7B
	/z5nqZK7G4ja3dR1GiZC16wZodEh65GYX+BQ==;
Date: Tue, 25 Aug 2026 20:36:31 +0100
From: Bradley Morgan <brads@mainlining.org>
To: hao.ge@linux.dev
CC: akpm@linux-foundation.org, atomlin@atomlin.com, da.gomez@kernel.org,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 mcgrof@kernel.org, petr.pavlu@suse.com, samitolvanen@google.com,
 sashiko-bot@kernel.org, stable@vger.kernel.org, surenb@google.com
Subject: Re: [PATCH] module: fix lost error code from codetag_load_module()
In-Reply-To: <20260824014736.35026-1-hao.ge@linux.dev>
Message-ID: <93AACC24-3583-4433-96F9-D1A2E87DC15C@mainlining.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 24 August 2026 02:47:36 BST, Hao Ge <hao.ge@linux.dev> wrote:
>If codetag_load_module() fails, err is never set and load_module()
>returns 0 after the module has been torn down.
>

I see!

>Fixes: 044d2aee6c57 ("alloc_tag: handle module codetag load errors as module load failures")
>Reported-by: Sashiko <sashiko-bot@kernel.org>
>Cc: stable@vger.kernel.org

Reviewed-by: Bradley Morgan <brads@mainlining.org>


>Signed-off-by: Hao Ge <hao.ge@linux.dev>
>---
> kernel/module/main.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/kernel/module/main.c b/kernel/module/main.c
>index 46dd8d25a605..afb810f0154c 100644
>--- a/kernel/module/main.c
>+++ b/kernel/module/main.c
>@@ -3568,7 +3568,8 @@ static int load_module(struct load_info *info, const char __user *uargs,
> 			goto sysfs_cleanup;
> 	}
> 
>-	if (codetag_load_module(mod))
>+	err = codetag_load_module(mod);
>+	if (err)

Nice!

> 		goto sysfs_cleanup;
> 
> 	/* Get rid of temporary copy. */
>

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
