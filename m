Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18D9469834;
	Fri, 28 Aug 2026 13:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787925010; cv=none; b=YsfPrB5coo3GY1rW0e2fQTqq12rTcYVbiVU1XKZ04YHl8Uz1AAmeIRuFHNyGRZWhuP6INBHuOFzntCMJh+nPwp71Lw0NUE1nM1XKyApmt7uZLB0wq6lM0APh3Efpc6FuiV+otIEewGDBWT/IM+ZOHExKxg9cSQVjFD5O2weeTo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787925010; c=relaxed/simple;
	bh=MNM2Sraq4K3iY6iYHq8qBZekPaB//ruHF0n2Pe5EE9I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s/orXk/wXG5bh4j/Ol7lHnwmdTqECyF54F4Bs5t4DQBCuoxLiuRYT7GvZWxTbqmMy4dU3z5Zm7qt3Igf6BOXBGyHjbLgikvD0dMc+bGLpZllsEXEbN7EBerN7mwCEMOgmEFit0h0czDBd1v5SdyUcFTJzbvm0v/OJ0qQULUnuoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=NrfI9ypO; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="NrfI9ypO"
Received: from omf02.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id BB1FA1403BE;
	Fri, 28 Aug 2026 13:50:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id CD8B780011;
	Fri, 28 Aug 2026 13:50:02 +0000 (UTC)
Date: Fri, 28 Aug 2026 09:50:52 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: syzbot <syzbot+3ef80b4ed02226d04a06@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, kartikey406@gmail.com,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@kernel.org,
 sh_def@163.com, stable@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 vdonnefort@google.com, vulab@iscas.ac.cn
Subject: Re: [syzbot] [fs?] [trace?] WARNING in eventfs_create_events_dir
Message-ID: <20260828095052.442529a5@gandalf.local.home>
In-Reply-To: <6a91709f.4d659fcc.734b4.001c.GAE@google.com>
References: <6a8c13ee.91706f20.16b6e3.02d5.GAE@google.com>
	<6a91709f.4d659fcc.734b4.001c.GAE@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CD8B780011
X-Stat-Signature: z491yxqsyqgox5f3i1worag15f1a6ykj
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+h7Gtx0qv3xGNpLED3o53D4lmvvufA+OM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=cr5uBqV5JgJ9Fno9O8Jwk+stMeWknF2R8YkK6zixjtA=; b=NrfI9ypOB/5PcxsukxvRyrA6I6XQt1we0foMDhOOuB7M3PtxvXCkTwHfJLBgpzX7efTahJkGv18ODlOJWCaVEmyR7Vb+wts6NrdgCjbhTiNb4FzBY4fxD4sY+CDmGsoL7PP6pbuiJE/LTbZ2uxD3tdPpx+v+f1L4MGf84aeIV6o=
X-HE-Tag: 1787925002-802069
X-HE-Meta: U2FsdGVkX1/eeJ/t4MKwRAoHEzQcGc24lczz+hypsh98K9gSWHbTmlNAHiHlEFYQ8CpueE9anMnhhDL7Gj/HTsoVQO6kacDuHsh3deNArKrdAJjut3lskN/Oimq9NUuRtzxFhHk6ZEdULqVPP5OJci8v5aYr1wrB/UNOMAz3iUsnE+CN9sFmN8waoPDBgS1nYHKba+bj6sJAhcis9M+ANr0vhcZwKXFD2ObeaaOr5XasTIpgJ8WkCjJJu27J/SmwWnfhIxDLepeqm63B/I3ZeUl327m5/uJvzT3Om5jYjsOhwRRnbDFFTBmpsCYdayul1ttT5go6qou/uG/JXsrulf5Zh3RN2JqwIL19XOIpf7v/x4yUt44EQMQ4IfPrbfvgvwQWq1fwnOL3WHSRAvofrjtF2iwpFatlioqctPpffkY4B4HlAPkH5KB/HDCYC2lbcuc2AZJxeCsmV9m9Mx2Mww==

On Fri, 28 Aug 2026 04:27:27 -0700
syzbot <syzbot+3ef80b4ed02226d04a06@syzkaller.appspotmail.com> wrote:

> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    818bebeb63dd drm/xe: Don't hand out the flat CCS storage a..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> console output: https://syzkaller.appspot.com/x/log.txt?x=16eddd49580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ccca94d2c01b9e78
> dashboard link: https://syzkaller.appspot.com/bug?extid=3ef80b4ed02226d04a06
> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17986d79580000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+3ef80b4ed02226d04a06@syzkaller.appspotmail.com
> 
> R10: 0000000000000000 R11: 0000000000000202 R12: 00007fae2ca35a9f
> R13: 00007fae2ca35adb R14: 00007fae2ca5ccc0 R15: 0000000000000002
>  </TASK>
> ------------[ cut here ]------------
> !list_empty(&ei->children)
> WARNING: fs/tracefs/event_inode.c:128 at free_ei fs/tracefs/event_inode.c:128 [inline], CPU#0: syz-executor340/6037
> WARNING: fs/tracefs/event_inode.c:128 at cleanup_ei fs/tracefs/event_inode.c:150 [inline], CPU#0: syz-executor340/6037
> WARNING: fs/tracefs/event_inode.c:128 at cleanup_ei fs/tracefs/event_inode.c:145 [inline], CPU#0: syz-executor340/6037
> WARNING: fs/tracefs/event_inode.c:128 at eventfs_create_events_dir+0xa3d/0xbe0 fs/tracefs/event_inode.c:838, CPU#0: syz-executor340/6037

This should be fixed by: https://lore.kernel.org/all/20260827151011.389282397@kernel.org/

Which is in my queue to send to Linus (and currently in my "fixes" branch).
I have some more patches to process before I send Linus my pull request.

-- Steve
