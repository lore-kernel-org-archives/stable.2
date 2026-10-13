Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2095753FD54
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 22:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791929152; cv=none; b=tn3Ilsanay3tz5Xgp4MOhH16FvHd8y0GxlFHY3mo+7UARsom9kgUvlbOAUg0dpzX0dpRA8WuhkXvE3vylrlL/t7rEXBjvauiUMGX4no6MMOGOFmbJ8r/r6IngIwA49DDhOKSm7EGs0WPE3KbXM6NM5D2HSsr+2dIkcbXVBwvem4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791929152; c=relaxed/simple;
	bh=KGcSNFnOdtZ1j8YPD0xStb9u5TMKlxiMTz+h15OXRao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-Id; b=tAUFX6xO5aX8jGdoqkEbzUnhiFX/A6ItP3o6NxsXq91T0DfYISshJacknEz0qFuM3M41jBeP9DUoq+YvhwU1rrTlqjgyYgqxFe+6k16iJFqjLJgSk4qgN7HhtFCbpuZRcgCrPITafw2MfkjlL+BmjqctJk93irM5q6njcXCWN/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7mLxaGO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7mLxaGO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 468CC1F0089A;
	Tue, 13 Oct 2026 22:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791929150;
	bh=QpQhe1h5SK+XILdjYJWIdfcanWqFAKZNLqOFT1Yptyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N7mLxaGOLWDBC28owwMXW01k1ZMxuZbl9WIJFlTgUNH6Lcu84gnBsuiQwFGj5Mfv6
	 +3jKX0h9+d7JjW050Or/lEdOfrDMEeLdeRVBIaZukxVhZMMnpxLmWWD8tX0nMQA5sl
	 GeSrX80HMCs60T+VJQPSn+4Wt20PXFpiRJZEmBIJqXP+Z5DFG+jsMwb4g0G/zopcOG
	 fNVhmwP6kwWQnxMbQ8JfhKgMWFF9byJe1icu0uuHITC+kjCr5+JjBAP8TDBFvz9PMs
	 La1tx3HvzI6JH11y4Yit6Y8/U6jNF9xsEotFWtPtEAWo/AT/9rgQNUb4rWixyzd7rh
	 gbgNs6aWOQjow==
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: lee@kernel.org
Cc: stable@vger.kernel.org
Subject: Re: [PATCH v2] tracing/histograms: Reject non-stacktrace fields for
 synthetic stacktrace fields
Date: Wed, 14 Oct 2026 07:05:47 +0900
X-Mailer: UndineD 0.1
In-Reply-To: <20261013112449.1006088-1-lee@kernel.org>
References: <20261013112449.1006088-1-lee@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20261013220550.468CC1F0089A@smtp.kernel.org>

On Tue, 13 Oct 2026 11:24:48 +0000, Lee Jones <lee@kernel.org> wrote:
> In check_synth_field(), when a synthetic event field is a stacktrace
> (field->is_stack) and the histogram field is not a "long[" stacktrace
> array, validation falls through to the generic size and signedness
> comparison.
>
> Because parse_synth_field() sets a stacktrace field's type to
> "__data_loc unsigned long[]", its size is sizeof(u64) and
> synth_field_signed() marks it as signed.  Consequently, any 8-byte
> signed scalar histogram field passes the fallback check, and its scalar
> value is subsequently dereferenced as a kernel stacktrace pointer in
> get_field_size() and trace_stack().
>
> Furthermore, checking strstr(hist_field->type, "long[") is insufficient
> because tracepoint fields defined with __bitmask() or __rel_bitmask()
> also have type "__data_loc unsigned long[]" or "__rel_loc unsigned
> long[]", whilst create_hist_field() treats them as 4-byte scalar values
> without HIST_FIELD_FL_STACKTRACE.
>
> Propagate HIST_FIELD_FL_STACKTRACE to variable references and field
> variables (whilst excluding variable aliases from per-element
> stacktrace capture), and reject any mismatch between
> HIST_FIELD_FL_STACKTRACE and field->is_stack in check_synth_field().

Good catch! Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks

>
> Fixes: 00cf3d672a9d ("tracing: Allow synthetic events to pass around stacktraces")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
> v1 -> v2:
>   - Check HIST_FIELD_FL_STACKTRACE instead of strstr(hist_field->type, "long[")
>     so __bitmask() and __rel_bitmask() fields are also rejected.
>   - Propagate HIST_FIELD_FL_STACKTRACE to variable references and field
>     variables, whilst excluding variable aliases from per-element stacktrace
>     capture.
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
