Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C17F1CD2C;
	Fri,  7 Aug 2026 00:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786063909; cv=none; b=FHetYjVfV4URivhD8kI6YLfTrjpvqbCiC/OCaLpR7XKhKRMv/vQUdGaJucVv+MqljJmVEd0CIpnfyL1Z7f1Qh0wG8oxmow9Gd6bLK7u6l2dbJSzZrMNogx+XkgmkHYXT7KfM48UIzu9gLBLbmKT/7T3eV6ATsgUm+vIp5CMJMYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786063909; c=relaxed/simple;
	bh=01keEssM2pfQURojUTved7d4H7nUBBDxgoI2vsofQhc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nQ03/mXdUV9gpIqlqM5xQToUbq3x19snYCN5F4LcEKmk9Ri0YRaYCItSJtencKiY70LtLZ0txrQbGeK9MqS6t57yq71dCG5TIOH0oHWTKBBR8pjcRS2yKTgCUz3/Okq1GeOYTE9n9nSch2EQS44WEEUV5HQ3jZ9ki8yOATuktnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 80256A0297;
	Fri,  7 Aug 2026 00:51:45 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id B9C3660010;
	Fri,  7 Aug 2026 00:51:42 +0000 (UTC)
Date: Thu, 6 Aug 2026 20:51:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: Song Liu <song@kernel.org>, bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, live-patching@vger.kernel.org,
 mbenes@suse.cz, jolsa@kernel.org, mhiramat@kernel.org, jpoimboe@kernel.org,
 joe.lawrence@redhat.com, mark.rutland@arm.com, corbet@lwn.net,
 stable@vger.kernel.org, linux-open-source@crowdstrike.com
Subject: Re: [RFC PATCH bpf-next v3 2/2] selftests/livepatch: update
 test-ftrace.sh for deprecated ftrace_enabled
Message-ID: <20260806205144.743c45e6@gandalf.local.home>
In-Reply-To: <CAOu3gNi8i9m7nEuKF28G8cYqJULvE4W6CuDeYVFk58z1xSbBoQ@mail.gmail.com>
References: <20260806153000.4184871-1-andrey.grodzovsky@crowdstrike.com>
	<20260806153000.4184871-3-andrey.grodzovsky@crowdstrike.com>
	<CAPhsuW7gOs2Opo5DRm+YKxBxwU+ncBmEAKHYO5jPjzxM9S8i5w@mail.gmail.com>
	<CAOu3gNi8i9m7nEuKF28G8cYqJULvE4W6CuDeYVFk58z1xSbBoQ@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 5zfnhh6ut1ssh6e4s9n16387x8pcxeb6
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: B9C3660010
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19eeDB4FpqEJL/2APlOa7B9xmLJHkxneOM=
X-HE-Tag: 1786063902-337523
X-HE-Meta: U2FsdGVkX18UJCA9frgFzHQVwTlQchQN2qwyC+8xDwuAPnoPiivACw5MKDdRrKw5LuoGR0kbuLNy7UAfNe7BKzeT+K6za6A9oswqa8WJYCkKTNq+utIxYiH1ChKn8wvkYeu/wTablTp1K8l5138fZ3XRTX7NlipfJRxyPjovZ45Y+7K2bpcy3ibHz58n4MO4g8SPKxLD5xFjt9VPcKT9NtGkyAqllOl8aWDiY4HivwFapf8zn6hZTmq5G12rfhsfG9gTTAhWWRuByBuo7L1R+1KCE0FX3VoAAkTo+V+9COyhlXYtPZpiikfSJedPpuZmPZgE5LHNuF26C72YNh3KlMZx3lMgZ9s5

On Thu, 6 Aug 2026 17:45:00 -0400
Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com> wrote:

> > Since the selftests are shipped with the kernel code, I think
> > we don't need to handle backward compatibility here. Instead,
> > we can just assume disabling ftrace is no longer supported.

Incorrect.

> >
> > Thanks,
> > Song  
> 
> I tend to agree but I think here[1] Steve and Miroslav asked for
> backward compatability. V1 was actually the way you prefer.

Right. We test older kernels (think LTS) with newer testing environments.
We need them to be backward compatible.

-- Steve
