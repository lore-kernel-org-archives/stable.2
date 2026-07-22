Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C31A339719
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 18:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784746541; cv=none; b=oRWRVeEOCJqoQks8rH0d/w7gBcN6aWgdyuVy1xnX+OkdbDQcwFvfMnOm59pGbjQJ8IprG95gn5VtZ/DxBePHmbHZaLpRvy+q31ykeEx0ibgGhoJO630GkhxWVB/e947dcByZA5brmdAFckTpU7qUy8RCv2ZHQKg+Q0YDgh9w2CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784746541; c=relaxed/simple;
	bh=1zOyJ/tGhoFd6ZlRmXt72LyeZkDLSjzJUH2rT1Rqgds=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=gBx5nO+sAY2iTgs6ACk8/6OPTSEufKV29hap8TVGpuhxSGKpzmXdxP/O4/PT2iRkyUX2Enp6GhJHZSGTVRQjKfVaQA4ohqAChSApmJQGwhZutDoz12dKAq3GETPQpgtRZubxzXnzzOGSmBHAYOObr8URGZ7LeALkbg6wd4UQd1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=u3Yy/d7r; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="u3Yy/d7r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1784746528;
	bh=S6Yr+DCUQJoAY9tW6JhRaWM6qyk8DFqNdqPcoW7ALbk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=u3Yy/d7rdtwfbCpin2PtEY40bpRvHR81XEtjwsTHB6oXRIWScG6wU3xwOOBcQ8mDG
	 N9mEi/lnkc7Eqs+FWVAEAPdHWXcNWS7npuE1tFK6bSNs3sittgJxFxGf7CzZCadrOo
	 fvmVm5a+X2lAEwYy/UbTdkwkCPhSgh45wBouUeU4=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4h53Nc6pQTz132r;
	Wed, 22 Jul 2026 18:55:28 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4h53NZ1hrgz132p;
	Wed, 22 Jul 2026 18:55:26 +0000 (UTC)
Date: Wed, 22 Jul 2026 19:55:26 +0100
From: Bradley Morgan <include@grrlz.net>
To: Thomas Gleixner <tglx@kernel.org>, gregkh@linuxfoundation.org
CC: stable@vger.kernel.org
Subject: Re: [PATCH 5.10.y] cpu: hotplug: Bound hotplug states sysfs output
In-Reply-To: <87pl0ekgxw.ffs@fw13>
References: <2026072036-pentagon-armory-48cd@gregkh> <87pl0ekgxw.ffs@fw13>
Message-ID: <5BEB4B1C-38BC-4726-AE39-B47867431B48@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On July 22, 2026 7:38:51 PM GMT+01:00, Thomas Gleixner <tglx@kernel.org>
wrote:
>From: Bradley Morgan <include@grrlz.net>
>
>commit 86f436567f2516a0083b210bedc933544826a2c3 upstream.
>
>states_show() adds CPU hotplug state names into a single sysfs buffer
>using sprintf(). With enough registered states, this can write past the
>end of the PAGE_SIZE buffer.
>
>Use sysfs_emit_at() so output is bounded.
>
>Fixes: 98f8cdce1db5 ("cpu/hotplug: Add sysfs state interface")
>Signed-off-by: Bradley Morgan <include@grrlz.net>
>Signed-off-by: Thomas Gleixner <tglx@kernel.org>
>Cc: stable@vger.kernel.org
>Link: https://patch.msgid.link/20260619163719.12103-2-include@grrlz.net
>---
> kernel/cpu.c |    9 +++------
> 1 file changed, 3 insertions(+), 6 deletions(-)
>---
>--- a/kernel/cpu.c
>+++ b/kernel/cpu.c
>@@ -2319,18 +2319,15 @@ static const struct attribute_group cpuh
> static ssize_t show_cpuhp_states(struct device *dev,
> 				 struct device_attribute *attr, char *buf)
> {
>-	ssize_t cur, res = 0;
>+	ssize_t res = 0;
> 	int i;
> 
> 	mutex_lock(&cpuhp_state_mutex);
> 	for (i = CPUHP_OFFLINE; i <= CPUHP_ONLINE; i++) {
> 		struct cpuhp_step *sp = cpuhp_get_step(i);
> 
>-		if (sp->name) {
>-			cur = sprintf(buf, "%3d: %s\n", i, sp->name);
>-			buf += cur;
>-			res += cur;
>-		}
>+		if (sp->name)
>+			res += sysfs_emit_at(buf, res, "%3d: %s\n", i, sp->name);
> 	}
> 	mutex_unlock(&cpuhp_state_mutex);
> 	return res;
>


Cheers Thomas! :)

Thanks!
