Received: from devianza.investici.org (devianza.investici.org [198.167.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC17C376BE2;
	Fri, 26 Jun 2026 15:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.167.222.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782486506; cv=none; b=tuZuunyPr08ONKs1knwWIQiYOq/ATvGj3CqoTYJlYWhEFjGEvdv+Z7ej0sVfL35eVVV5eJW9K6Sa6Ev4e8RI6n7c9aEfcd3oTmJI366xbx7vM1qVyNKGz6glXBnZq6g1ZWJhWZcChv/xReY+nMDrhfoob6TZ5x/PXgt+v7Qb2Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782486506; c=relaxed/simple;
	bh=F4ljnoGc/56n7H6lPb2KzFJOK3AWxFO1R1S0xmBERp8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=dxCIhBwd6+XkT0nTWtE4K6lcVYuzPh8wDQEb86+5c+s1FVXf7/GKo11n1sDMtHFoNvHcIaI5nY0sNXOwnyc37pxvX5HTTpuvYyn92jTIjpwrswujx8Py6etpdP9V+2k7syBDfJyTudswC+aTc64agxVQ9c5A/y+u3YFtLWv5CCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=WTKB4QMl; arc=none smtp.client-ip=198.167.222.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="WTKB4QMl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782486501;
	bh=F4ljnoGc/56n7H6lPb2KzFJOK3AWxFO1R1S0xmBERp8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=WTKB4QMl8XYzBMKheH0O26pR7Uov5N4X83dtdsq8IRYuXuL456THRQK2HBTixEonP
	 LxLz8G0VUP96ahsVlgJIF3wydWm0rtyfzc1izyVpjux0KbXTkoBGCf/CwYhjylo9vn
	 rx+aHYfVjBZ2+3W6pidqFKbqXaxgG3j6PwRopEZ0=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with ESMTP id 4gmzZY640wz6vX9;
	Fri, 26 Jun 2026 15:08:21 +0000 (UTC)
Received: by mx2.investici.org (Postfix) id 4gmzZY32x9z4y2q;
	Fri, 26 Jun 2026 15:08:21 +0000 (UTC)
Date: Fri, 26 Jun 2026 16:08:22 +0100
From: Bradley Morgan <include@grrlz.net>
To: Oleg Nesterov <oleg@redhat.com>
CC: Andrew Morton <akpm@linux-foundation.org>, ebiederm@xmission.com,
 Christian Brauner <brauner@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Adrian Huang <adrianhuang0701@gmail.com>, Marco Elver <elver@google.com>,
 Kexin Sun <kexinsun@smail.nju.edu.cn>, Thomas Gleixner <tglx@kernel.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] signal: avoid shared siginfo namespace rewrites
In-Reply-To: <aj6Va2nNBZvDJqP5@redhat.com>
References: <20260622164029.11474-1-include@grrlz.net> <aj6Ms6uygc1vtySn@redhat.com> <FC7EAB84-0845-4DA3-AD43-3B30B47507E5@grrlz.net> <aj6Va2nNBZvDJqP5@redhat.com>
Message-ID: <D25A403E-7A0F-4654-B4E5-F6411B4C7A4C@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On June 26, 2026 4:06:19 PM GMT+01:00, Oleg Nesterov <oleg@redhat.com>
wrote:
>On 06/26, Bradley Morgan wrote:
>>
>> On June 26, 2026 3:29:07 PM GMT+01:00, Oleg Nesterov <oleg@redhat.com>
>> wrote:
>> >To avoid the confusion, let me reply to V1 again.
>> >
>> >Acked-by: Oleg Nesterov <oleg@redhat.com>
>> >
>> >IIUC Eric is fine with this change too.
>> >
>> >Andrew, can you take this fix please? We will send more changes on top
>> >of it.
>>
>> Thanks again oleg.
>>
>> Andrew did reply to V2.
>
>OOPS... where? I didn't get any email from him in this thread...
>
>Oleg.
>
>

Ahh, it was a off list email, apologies..

I don't read much to the To: field.

My bad.

Thanks!
