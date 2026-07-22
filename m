Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53102E571;
	Wed, 22 Jul 2026 17:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784741265; cv=none; b=mogMjmkPewP+NCVPu2EpBc1TiKU/hxK4S1/PN16JfGrJzeLbI+VrX+P73yYcpt89xuH64MEL3FmocDOMLlO4dJB+nDgmSPy/ycSuA3AKbxbxIMWgofFzAEXv62BWJJ/fI8bJptBLdhfmytNG2vFnsFtMkFQnPKpCoAtIOPBJY6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784741265; c=relaxed/simple;
	bh=oa6HeafCA/4Ipm5mKYfwc7E4hf9kZhpzP4Z7j7YMFN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7XLx4QRErp0jC+bkfIhdpepNa2aL5IddBLR0WjbzpdgRTPytukSHoTfmy7BHHnlzzH717VFGetrIvHEcribCpW2bDp6BcHtBsqUiaegVFo3NWoAmXFM7GcOl3ytC/Xa10rn2YA8QaQbh4pOBstjEE2irc8HmieyNLK/8FS1q4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OZo6eH8s; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OZo6eH8s"
Received: from CPC-beaub-VBQ1L.localdomain (unknown [70.37.26.65])
	by linux.microsoft.com (Postfix) with ESMTPSA id B0F9620B7167;
	Wed, 22 Jul 2026 10:27:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B0F9620B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1784741247;
	bh=TPnnRa0tCoaocwL55Nt5Pn8vDAh0bEuohzp5OnlOCXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OZo6eH8sZKoH0CzTvecmPdhGunhO28f8l1O6oP3XT+gGYTpe4MGyi6JhIrPV6dQut
	 ypfPprvocNBJxq9soJnzgp3yF24YjVUVsBdkuNgEYZjnB31c6Ua1vjI4nS4ZymBAwf
	 OVYH4AzPykomVUlD96rLQfyrlHUdwbnG9iGiY1A4=
Date: Wed, 22 Jul 2026 17:27:32 +0000
From: Beau Belgrave <beaub@linux.microsoft.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Li Qiang <liqiang01@kylinos.cn>, mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/4] tracing/user_events: Validate explicit struct field
 sizes
Message-ID: <20260722172732.GA212-beaub@linux.microsoft.com>
References: <20260722061040.112747-1-liqiang01@kylinos.cn>
 <20260722061040.112747-3-liqiang01@kylinos.cn>
 <20260722123310.7da7166b@gandalf.local.home>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722123310.7da7166b@gandalf.local.home>

On Wed, Jul 22, 2026 at 12:33:10PM -0400, Steven Rostedt wrote:
> Beau,
> 
> Can you review this?
> 

Sure thing.

> Thanks,
> 
> -- Steve
> 
> 
> On Wed, 22 Jul 2026 14:10:38 +0800
> Li Qiang <liqiang01@kylinos.cn> wrote:
> 
> > User event declarations permit an explicit size for a struct field. The
> > parser accumulated that size in an unsigned offset, then assigned the
> > parsed unsigned value directly to signed field metadata. Oversized
> > declarations or cumulative offsets could wrap or become invalid signed
> > values.
> > 
> > Validate an explicit size is representable as int before storing it. Keep
> > the running offset signed and reject additions exceeding INT_MAX, so
> > invalid field layouts are rejected during declaration parsing.
> > 

Li Qiang, thanks for looking into this!

> > Fixes: 7f5a08c79df3 ("user_events: Add minimal support for trace_event into ftrace")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Li Qiang <liqiang01@kylinos.cn>
> > ---
> >  kernel/trace/trace_events_user.c | 16 ++++++++++++----
> >  1 file changed, 12 insertions(+), 4 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> > index 8c82ecb735f4..fd5b3946921c 100644
> > --- a/kernel/trace/trace_events_user.c
> > +++ b/kernel/trace/trace_events_user.c
> > @@ -1197,10 +1197,12 @@ static int user_event_add_field(struct user_event *user, const char *type,
> >   * Format: type name [size]
> >   */
> >  static int user_event_parse_field(char *field, struct user_event *user,
> > -				  u32 *offset)
> > +				  int *offset)
> >  {
> >  	char *part, *type, *name;
> > -	u32 depth = 0, saved_offset = *offset;
> > +	u32 depth = 0;
> > +	unsigned int field_size;
> > +	int saved_offset = *offset;
> >  	int len, size = -EINVAL;
> >  	bool is_struct = false;
> >  
> > @@ -1261,8 +1263,11 @@ static int user_event_parse_field(char *field, struct user_event *user,
> >  			if (!is_struct)
> >  				return -EINVAL;
> >  
> > -			if (kstrtou32(part, 10, &size))
> > +			if (kstrtouint(part, 10, &field_size))
> >  				return -EINVAL;
> > +			if (field_size > INT_MAX)
> > +				return -E2BIG;

We have a hard coded limit on arrays already of 1024 (MAX_FIELD_ARRAY_SIZE).
We could have a much smaller max here if we want to. However, since this
will backport, I'm fine keeping it this larger value in-case someone
really needs this much space for a struct.

> > +			size = field_size;
> >  			break;
> >  		default:
> >  			return -EINVAL;
> > @@ -1281,6 +1286,9 @@ static int user_event_parse_field(char *field, struct user_event *user,
> >  	if (size < 0)
> >  		return size;
> >  
> > +	if (size > INT_MAX - saved_offset)
> > +		return -E2BIG;
> > +
> >  	*offset = saved_offset + size;

We should really use check_add_overflow() here and return -E2BIG if it
fails instead of a hand coded check. Please update utilizing that.

> >  
> >  	return user_event_add_field(user, type, name, saved_offset, size,
> > @@ -1290,7 +1298,7 @@ static int user_event_parse_field(char *field, struct user_event *user,
> >  static int user_event_parse_fields(struct user_event *user, char *args)
> >  {
> >  	char *field;
> > -	u32 offset = sizeof(struct trace_entry);
> > +	int offset = sizeof(struct trace_entry);
> >  	int ret = -EINVAL;
> >  
> >  	if (args == NULL)

Thanks,
-Beau
