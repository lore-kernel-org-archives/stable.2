Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4B537755C;
	Sat, 22 Aug 2026 15:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787412210; cv=none; b=TIcBii6vNiWtEzVjyFo9iR/G2xzd/sytVbI2t9N5xOgY//gh9CDnNDtC75C9F8GTSybvSAPCyrB54yxHMjVyVGqtsUt9UpnAnKQo6KdxHXBs4iSEOxmXcHELpiKxmgZvm9E8CqXlcy5ab1prRqv5QstxQlKfTM7ulsHwnOq3reA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787412210; c=relaxed/simple;
	bh=WrJatvS+dpsgvexrFJw28Fc/KzpHX/g5DZqmk0x10VM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yjli5pmJHZ9/Mol9NvX9zbM+RqsZjnf9FEU2Qt1Jyal5rQ11SXGO8+RauCV2arwtlCD6bB5cWgRPFUXsj5N+F6QWStFp8vZk8x8IRJM466P5eW3/9qLL1h0A2mZgkm+iSkDdJLTYP0jXy9hHhKulkDrPU2oyU/MrhWkkoOna2BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=LU3Tlu5E; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="LU3Tlu5E"
Received: from omf11.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id DD4DF1A019A;
	Sat, 22 Aug 2026 15:23:20 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 64C072002C;
	Sat, 22 Aug 2026 15:23:04 +0000 (UTC)
Date: Sat, 22 Aug 2026 11:22:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: =?UTF-8?B?SsOpcsOpbXk=?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, mgorman@suse.de, include@grrlz.net,
 bsegall@google.com, dietmar.eggemann@arm.com, kees@kernel.org,
 kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 vschneid@redhat.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] fork: initialize function graph state before
 copy_exec_state()
Message-ID: <20260822112248.1b7e1b1d@fedora>
In-Reply-To: <20260822084927.547141-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20260822084927.547141-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: ajshg4cetoi7kmjm6yugn1ah3akmwne5
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 64C072002C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/qlZgXADOrmF5uNiwy2VX4iR+37QC+ua0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=WrJatvS+dpsgvexrFJw28Fc/KzpHX/g5DZqmk0x10VM=; b=LU3Tlu5E9WSgJxSNWsL/2vPXgUhe5EFm0BYPSVPu6drm7C50bC8/L89hVt2/9AlzA+Yks7JGZ4GdAiJkNwrwO2dpI/ms/oa77mR9N7/ygFttYOV0twgNAzf7sEcRDB5BTXcb7D1mr8kHnAzLL8VjlxN1I4eN7aIXBnDAn+TPqXQ=
X-HE-Tag: 1787412184-401758
X-HE-Meta: U2FsdGVkX1/EQPw/mJTjICcbGMkIafRXyWn0hFafPUl7sXG2e1khZHtjupHcjqNglVg48miZ0LvxnwKP5Wd1l2RYRGTOPx0Jhs6zNAfz5mi+0gVIRFydJJBtShVAm6z0N1E5BxBpbu4Fxa64G9l2HoCnbqkZFEeTYbpzcwQitm6cLbzZtiXVeWOkRhdwIq2JeFoKn65Bou4/Zinu6QOwvKmRtTAV+iAeowY+75dy6mrVgL0D4LfRWQpIsjJT3yjIdxMXM5gfZBIPcmGp7e1T8+iDcndX9bZGSvlcE1/wbPHtGj54C0brJr4aYF7RlK21GqpbuskWc+u5qPYHDYasoFUuhVQghrIg

On Sat, 22 Aug 2026 08:49:27 +0000
J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr> wrote:

> dup_task_struct() copies the parent's task_struct, including ret_stack.
> ftrace_graph_init_task() clears the copied function graph state, but it
> currently runs after copy_exec_state().
>=20
> For non-CLONE_VM forks, copy_exec_state() allocates a new task_exec_state.
> If that allocation fails, copy_process() reaches bad_fork_free and
> free_task() calls ftrace_graph_exit_task(). Since the child still carries
> the parent's ret_stack pointer, the unwind frees the parent's active
> function graph return stack. The parent subsequently accesses freed memory
> from function_graph_enter_regs().
>=20

As this effects function_graph tracing, please resend and Cc:
linux-trace-kernel@vger.kernel.org so that it gets to the proper
patchwork. It will need to go through my tree so that it gets the
proper testing.

Thanks,

-- Steve
