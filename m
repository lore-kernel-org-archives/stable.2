Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793813428;
	b=w/6+JMVn66GDF2ti74gv8BReX38YjpTofPmlwKvAtuKV+M9ABOkyhEYHeYZ9wPsCtob0
	 qWch/mAJp6zWPH48M3uKsKGAbUs55PrSO28Hr11g1i1pAdkjRzbXJJpOxHFIeqMXnDxn1
	 4LkvWlS98J3BRZk0OiUg2VSH8oK/0+KzvBT6ZLRVLg6MspliRyICPG4jrxRY4OUF1ogyA
	 ONfHOfe8qG9Ey/gfuKWTKvEPLMYJKs2C9ecOwVXxMLE6BtU/Fsx+B8/k9tmJ1XIwp084K
	 0ThrBSOfFmQCsyKPo6+eLX9dKnn9uhXaxWJmbmLf6uH6ByDOximXJK/AED80j0xfLkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793813428;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=ANl2dv7EUq47TWuxP6+ELRbu4bPlHhCGg5PPFu8swJY=;
	b=ZI9nwtkhbzPTQqFRkDB+A6ovgg7JlqVhSKESFOv7Q+YNWSkTsQrBce0syvE6OGalSqEh
	 dRlg5UUUYGzv/H3VYVBbu9qTimhydYtePu4awmooKL+XT5XqnZ+VReT1TZbmBsuCEBR91
	 5siigtzCHuzEL9R4EFFKnm8B8BvWsMxInq/8MIDPV+xsDstwsDwnWG4CIAbQ56l13NqjZ
	 6pUwzVPC7Gxqru/1Iu7dy/aOtSsPwAjWuF+1o/xYfckOLBJ8tVt9hxKat3b3Jjr1d3VMQ
	 fadTbz9xREx9Ib7Ia/EGvso5ErF5BsJHQK6dRuiznFIUtQdj6V2CBayNGjZWC1Aonzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	arc=none smtp.remote-ip=216.40.44.17
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695FC606B02E
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 17:30:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 695FC606B02E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 64820A849A;
	Wed,  4 Nov 2026 17:30:23 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 76CDF20010;
	Wed,  4 Nov 2026 17:30:21 +0000 (UTC)
Date: Wed, 4 Nov 2026 12:30:19 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
 sashal@kernel.org, DL Linux Open Source Team
 <linux-open-source@crowdstrike.com>, Jiri Olsa <olsajiri@gmail.com>
Subject: Re: [STABLE REQUEST] ftrace: deprecate the ftrace_enabled disable
 switch
Message-ID: <20261104123019.1f7ed0c1@gandalf.local.home>
In-Reply-To: <CAOu3gNiggAdifeAUpycoO-zGKb0k2-nZqWrtDXMXm_HXT8L1Vw@mail.gmail.com>
References: <CAOu3gNgTSWE84fgdc1iUNKwes7E6u_X6b8pjZKBULEJWB=RAqQ@mail.gmail.com>
	<20260820182015.4272b7a4@fedora>
	<CAOu3gNgv91dq8jLShteRWphrSgNWQ1o1dkNxRr577ez7pMuv6g@mail.gmail.com>
	<20261104083903.0d7cdb06@gandalf.local.home>
	<CAOu3gNiggAdifeAUpycoO-zGKb0k2-nZqWrtDXMXm_HXT8L1Vw@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 76CDF20010
X-Stat-Signature: g8dd7capu6ikqqrmhhq89znoe45mrrgu
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+ZKuDkKl1jnGwTsImfa95fwo5xpUYhMO8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=ANl2dv7EUq47TWuxP6+ELRbu4bPlHhCGg5PPFu8swJY=; b=AwnPwEgfUSSMqxlegHRvfm154RzEo+rE0R80Rg7ctbclWn0uH8y8zKlLw18WQ9gOIHhWYqPo4bLKy9lar64Z8LAp0YCsx7d+kt0FvkZQrZdFxr1f68/uwt5+SRG4s5HKnqkWT13NlUg1+N6m2Gej8kltJjQkrpr5EK/lJJm5/AA=
X-HE-Tag: 1793813421-610062
X-HE-Meta: U2FsdGVkX1+7wNPf2zho1NkBq9AhlM9V1/jCjCh+rkEnagPERYne8tgu0fgwTzjWXTEEjs3ljmGuEX8ucuSpH0M7xEtcS/OMDmchqOa99XpxNRkOs8OEkwkUUZN7cu8FJcLSWWuabrbe57edDO5WeznM4sjUfAVajGpGZWMmXd5OyK0fLDtNZCyOTqIe52UepnymodJ63QDHaKxjbKDzZl67sypH0YyYvFY2Jior2Tw6NjZz1/HlxVeI8bxjqDF4HXfe+Elun/sIdENW64W7dSYi96cS4RIAaHCFXhgTtJEMiOhwUcBB8rb353G/CW6czYVMtws1un4bpx2nbHlny7KERvuw1IaS

On Wed, 4 Nov 2026 10:43:37 -0500
Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com> wrote:

> Ok, so just to clear my own confusion: do we want to directly present
> this to stable as a backport fixing a bug, or go through merge to
> mainline first and then only backport? If we do want to take it into
> mainline then I think the selftest patch is beneficial especially
> because Jiri found some case that breaks there that needs furhter
> invistigation [1].

It has to go to mainline before going to stable. I'm fine either way for
the selftest as that's really up to the bpf maintainers.

-- Steve
