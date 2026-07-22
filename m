Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77313F4116;
	Wed, 22 Jul 2026 16:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784737980; cv=none; b=BGUTM5pKgHWEywq8WeCE9KD6s9S61N7VRkGXeOkPkOZPQx5JbrPEnO5DFvgqcPiELhr4W+rVbnJ2Ln1u0drkglG2qKLDYLn+1H/kBmCtJR/x1TyX1/IbBCD2NfXmJgUSvfywteZQ6FD6MCok82YZRrlZQ0yBAGDvdpukEe9hju4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784737980; c=relaxed/simple;
	bh=A1X4jlbHmfdLxnOq0mtlD0Iah+B9g2IxUL29gBW9jRU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YPSpPJFezrM1qVu/T0/MvUl+FjJrC9dPFAvUk/52CzzYdhN9pDu3ra3dp6CwSq3Qe/S2Svmp1x7DLPO0tTsWrA0y2TqaLpjvMD9veKKw1DrPf9y0fdxOntqORleM9nbXpXF6o5q5aPjW3mL2jdm9Q0Henh4DjgxGUNFLqTkIOj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 8764E120225;
	Wed, 22 Jul 2026 16:32:51 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id A740B2F;
	Wed, 22 Jul 2026 16:32:49 +0000 (UTC)
Date: Wed, 22 Jul 2026 12:33:10 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Li Qiang <liqiang01@kylinos.cn>, Beau Belgrave
 <beaub@linux.microsoft.com>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/4] tracing/user_events: Validate explicit struct field
 sizes
Message-ID: <20260722123310.7da7166b@gandalf.local.home>
In-Reply-To: <20260722061040.112747-3-liqiang01@kylinos.cn>
References: <20260722061040.112747-1-liqiang01@kylinos.cn>
	<20260722061040.112747-3-liqiang01@kylinos.cn>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: A740B2F
X-Stat-Signature: ancedkmtn49abdjpkeh6e8fsaaxwouzh
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18J1v51EZnju6bHkxJXDl6BSE+LrZ0wHeQ=
X-HE-Tag: 1784737969-937150
X-HE-Meta: U2FsdGVkX1/SwjgGrILjnwnYCS/aLOcJOtjOmWGz8QRQ5RDThEEY1q4ICl/uONdqlPkKyXW0WfDdpnJ/Za7nCEJ6g1WLvIGJzzBuhogkpRhebJBreKQnOW86BOU5/1vAIA9JzUV+SNgNsdc1PrU+CPomfK+v+krEPNf1U6z1fcOBez0AvIr3CjxVXSgHlqLo/ppTdbjCyvyqbXUcm/DRVFwVCB3L+LxwPNSz6hV1e0jRghljC6yG0rdjcZ0Gfn33WeOnKuDUuVlLvikwFSVF1DMNVXNcoiUU6RXM+vA1OLZZVr/GQK9XKMhuJ2RkFtCbQgl+F0Wxru+c44has80ULrMgivxWXZFJ

Beau,

Can you review this?

Thanks,

-- Steve


On Wed, 22 Jul 2026 14:10:38 +0800
Li Qiang <liqiang01@kylinos.cn> wrote:

> User event declarations permit an explicit size for a struct field. The
> parser accumulated that size in an unsigned offset, then assigned the
> parsed unsigned value directly to signed field metadata. Oversized
> declarations or cumulative offsets could wrap or become invalid signed
> values.
> 
> Validate an explicit size is representable as int before storing it. Keep
> the running offset signed and reject additions exceeding INT_MAX, so
> invalid field layouts are rejected during declaration parsing.
> 
> Fixes: 7f5a08c79df3 ("user_events: Add minimal support for trace_event into ftrace")
> Cc: stable@vger.kernel.org
> Signed-off-by: Li Qiang <liqiang01@kylinos.cn>
> ---
>  kernel/trace/trace_events_user.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> index 8c82ecb735f4..fd5b3946921c 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -1197,10 +1197,12 @@ static int user_event_add_field(struct user_event *user, const char *type,
>   * Format: type name [size]
>   */
>  static int user_event_parse_field(char *field, struct user_event *user,
> -				  u32 *offset)
> +				  int *offset)
>  {
>  	char *part, *type, *name;
> -	u32 depth = 0, saved_offset = *offset;
> +	u32 depth = 0;
> +	unsigned int field_size;
> +	int saved_offset = *offset;
>  	int len, size = -EINVAL;
>  	bool is_struct = false;
>  
> @@ -1261,8 +1263,11 @@ static int user_event_parse_field(char *field, struct user_event *user,
>  			if (!is_struct)
>  				return -EINVAL;
>  
> -			if (kstrtou32(part, 10, &size))
> +			if (kstrtouint(part, 10, &field_size))
>  				return -EINVAL;
> +			if (field_size > INT_MAX)
> +				return -E2BIG;
> +			size = field_size;
>  			break;
>  		default:
>  			return -EINVAL;
> @@ -1281,6 +1286,9 @@ static int user_event_parse_field(char *field, struct user_event *user,
>  	if (size < 0)
>  		return size;
>  
> +	if (size > INT_MAX - saved_offset)
> +		return -E2BIG;
> +
>  	*offset = saved_offset + size;
>  
>  	return user_event_add_field(user, type, name, saved_offset, size,
> @@ -1290,7 +1298,7 @@ static int user_event_parse_field(char *field, struct user_event *user,
>  static int user_event_parse_fields(struct user_event *user, char *args)
>  {
>  	char *field;
> -	u32 offset = sizeof(struct trace_entry);
> +	int offset = sizeof(struct trace_entry);
>  	int ret = -EINVAL;
>  
>  	if (args == NULL)

