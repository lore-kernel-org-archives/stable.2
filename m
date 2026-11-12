Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794482094;
	b=3nMqQjZSTvm0/OehPNWVUI8/3S+P5kPYneNvRH68QcgEld/9f4myRNBXFZ86wAuK3xMf
	 7dl1/LvFx5Iufyg76sAq9foqezA/nYWHxUvlD/jHfidHL3WWcpC4qTuiopAC+CbF5KOgb
	 o67Ob7iRFftHJGGdJHU63NtSHkEBfqCrDpIRL+glr5TKLUsI370QZdYkjCWyn2z/PIUWO
	 KNSKDnxtaFVjKDotIolzaIwmGhRZXmb6MeXWc/EO9RZdoENznQ8BbsW2wbS/hNRdPAmIo
	 1FaXy6s5j8wv7eInm9GuwTjbk9uXwk2U7T+DlJqQxma1OTYw9eYOgADNHrlyGKy9gMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482094;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=0JByptMTEXe448xXyd4+0at0Pd+9SH9sb0GM6QLHhIY=;
	b=qi4FNa+WkbwYTTQqdaGdCgjOeTGkHpyk+wObaV04rYZyJ5xgToG6k+mBY9JNxgWSXWsk
	 w1UUH/p1jKoicka+ihSRmjXBPSprkpLbhXtG2czTkEeTBTzwUo9PBslqVcZ5GhjcmcLoI
	 AoQz+dRfl4ZP+8fVqu6ssH+tYZdPfUCWKuO6+2He2mHQitj0XPxrxGp3qmFKHfHyKnuWZ
	 nZO6THFfaVWK11xun3ASp2jWyPtkLfnMCyRXIr3NkfU/NyGktdRnT2Xkq8VHlrnm3ngOn
	 UhjUwOcgtfC7aXIRUc+IV6XbAb/zRfm4iC3Zvw3q4bALiXjFebpJryrz0Cjj8PQOVIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=pi3jP69W;
	arc=none smtp.remote-ip=216.40.44.11
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2A1606A327;
	Thu, 12 Nov 2026 11:14:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D2A1606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=pi3jP69W
Received: from omf18.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 667C312054C;
	Thu, 12 Nov 2026 11:14:45 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id C204C2E;
	Thu, 12 Nov 2026 11:14:34 +0000 (UTC)
Date: Thu, 12 Nov 2026 06:14:23 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: Breno Leitao <leitao@debian.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Steven
 Rostedt <srostedt@redhat.com>, kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] ring-buffer: Handle a reader taking the new head in
 rb_handle_head_page()
Message-ID: <20261112061423.59e02261@fedora>
In-Reply-To: <avRuXVxVrp-Kjiqj@google.com>
References: <20261105-ring-buffer-head-moved-v2-1-05da40cebccc@debian.org>
	<20261105155729.0f9c7e4d@gandalf.local.home>
	<avGQnBjyUMwunknT@google.com>
	<20261110025202.78c8c03a@fedora>
	<avRuXVxVrp-Kjiqj@google.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
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
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: C204C2E
X-Stat-Signature: u1dm931fhwbond7qm43dr4cr4ktj669n
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19rjI8iG0EdGt199fFgeH19Zf6IZZPjtSs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=0JByptMTEXe448xXyd4+0at0Pd+9SH9sb0GM6QLHhIY=; b=pi3jP69WsiLOs5NQrb4VnjOuH2kGtfOTopuC4ge7PHLW1Hijwt4P5nTA19HdAppONIj0N8EuSTrfVOvHafdY8OOmisUnJAjEjuV8Hmpse4xHSri9v+3gbzTFK4ugxqbNoAzqFx6lM18Ey4xXiVJxximDYIYU/kjkV+qIag0WC5k=
X-HE-Tag: 1794482074-382458
X-HE-Meta: U2FsdGVkX19uZPqE6mfIElSM+uF/LwRqEm6HZ3dbM4LTqX6Dqr7fjvGLZOgphginqPSx4y40GVQtnK8gCerNqQVt5Ytyg9zR830fyaug/q4Q7XBakk1+/T2r3zyqnzXMYP5rEjlPfd2ZH6WHjD/+uCQw4llkbC1GTPfCc/9VIh9NrFjtOfAXA6YzUiDJhwJ+DkaQU2C82N3iPzslCeZNz2qgEtffs/um3yUFqSqTXMPRyd6Zy6sTbP+mwzR3eqINqr/3N4etHjXHe/j3IALx7RmRJx0Vx4BguHvHK+VT4Ngi2SonadIJROwfg8bKVg6bMlj75cbO3iH4dGeQyh33adnkbKuKh8mV

On Wed, 11 Nov 2026 13:32:13 +0000
Vincent Donnefort <vdonnefort@google.com> wrote:

> Yes, now I spent more time on it, I believe it makes sense. I looked at what we
> could do and I'm trying to use a temporary RB_PAGE_HEAD | RB_PAGE_UPDATE. This
> link flag is then only converted to RB_PAGE_HEAD by the outer writer. I believe
> this would fix the race entirely... However that means the reader spins as long
> as the buffer writing is interrupted, which I admit is far from ideal.

But it is only interrupted by interrupts ;-) which should be fast.

No different than waiting for a spin lock whose owner got interrupted
by an interrupt.

-- Steve
