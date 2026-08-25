Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806BC3FF1C0
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 11:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787657085; cv=none; b=DQ718zcwz+Q1ToxNZi43Oj5OR4dnH061vmIhoTT6zEvLxwSKrNA6UOrM0e5RsJMWLRSkATmYj5nnvcl+DP8yFNDeEwB6W1bUfJl/iI9pue616o2Z8mxr+44QjmV8hTY3PmBgZCqc70hcgumZxGEtDWmmBABPTBnha0Qnfpb0WBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787657085; c=relaxed/simple;
	bh=gD7EqeK6vaX4+RZQN7skGDJWFk3nXe3YWZTa+h0Ggbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WYdnqGuixak2Qm8DZiLAC8Bxk5Q+yXy91VQ9tZkMa4kt+iQJxPGov9z6+s0utVg//KHJAAzw1t/zNOjfPi9zCyXd0jdYktUERT1tM0lrxzRgZYEz/RB58irepPuZqTF5d3cRcZQWVgb9vHftzg/EJFMRrXlD0fLQ+4+IGeXH1NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCDQXxNX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCDQXxNX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CFAE1F000E9;
	Tue, 25 Aug 2026 11:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787657082;
	bh=RHWYBQNU+J2n6W5v0qYNDMe0p76yakZE6puwy2D5kek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RCDQXxNX783kmJpWcLzcajp3R8DoqPVgw4B4DraHWTlsE4IQz4zhh4EuyMfTBOBlL
	 pAdW7cat3+AFXir5zyz7CypiJsTI2EnhO4we5Wem0FB2NzurSXHSq1G4BBCM96SNhR
	 yLInZ+3i4Brc93Gm1Z2OBiZTK4xDdMV1yGyqN/AcLB9MAwkFbHnHPQO7nBaBXfk5QZ
	 cpow0EnKp2Au2ASmEPNGtYI9j4oZgEQPDWjO/v+dlEEewtT8fNlI9nBo+FC1Qu8YjK
	 /U0dpSCnNzWG26OcKD7TsyRlh40AClYS9HTy1j0uG6NjScLDUi2ssdj7MzpyFbXjem
	 O87KM1/idIXEQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/9] selinux: fix style issues in security/selinux/ss/policydb.h
Date: Tue, 25 Aug 2026 07:24:32 -0400
Message-ID: <20260825112440.3543785-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082022-circle-gooey-f888@gregkh>
References: <2026082022-circle-gooey-f888@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paul Moore <paul@paul-moore.com>

[ Upstream commit a32582db36dcf3b23f860e092485e5e06b1b966c ]

As part of on ongoing effort to perform more automated testing and
provide more tools for individual developers to validate their
patches before submitting, we are trying to make our code
"clang-format clean".  My hope is that once we have fixed all of our
style "quirks", developers will be able to run clang-format on their
patches to help avoid silly formatting problems and ensure their
changes fit in well with the rest of the SELinux kernel code.

Signed-off-by: Paul Moore <paul@paul-moore.com>
Stable-dep-of: b98a8ac50775 ("selinux: require a class's permission values to cover its permission count")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/selinux/ss/policydb.h | 192 ++++++++++++++++-----------------
 1 file changed, 95 insertions(+), 97 deletions(-)

diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index b97cda489753d..4bba386264a3d 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -8,15 +8,13 @@
 
 /*
  * Updated: Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
+ *          Support for enhanced MLS infrastructure.
+ *          Copyright (C) 2004-2005 Trusted Computer Solutions, Inc.
  *
- *	Support for enhanced MLS infrastructure.
- *
- * Updated: Frank Mayer <mayerf@tresys.com> and Karl MacMillan <kmacmillan@tresys.com>
- *
- *	Added conditional policy language extensions
- *
- * Copyright (C) 2004-2005 Trusted Computer Solutions, Inc.
- * Copyright (C) 2003 - 2004 Tresys Technology, LLC
+ * Updated: Frank Mayer <mayerf@tresys.com> and
+ *          Karl MacMillan <kmacmillan@tresys.com>
+ *          Added conditional policy language extensions
+ *          Copyright (C) 2003-2004 Tresys Technology, LLC
  */
 
 #ifndef _SS_POLICYDB_H_
@@ -39,104 +37,103 @@
 
 /* Permission attributes */
 struct perm_datum {
-	u32 value;		/* permission bit + 1 */
+	u32 value; /* permission bit + 1 */
 };
 
 /* Attributes of a common prefix for access vectors */
 struct common_datum {
-	u32 value;			/* internal common value */
-	struct symtab permissions;	/* common permissions */
+	u32 value; /* internal common value */
+	struct symtab permissions; /* common permissions */
 };
 
 /* Class attributes */
 struct class_datum {
-	u32 value;			/* class value */
-	char *comkey;			/* common name */
-	struct common_datum *comdatum;	/* common datum */
-	struct symtab permissions;	/* class-specific permission symbol table */
-	struct constraint_node *constraints;	/* constraints on class permissions */
-	struct constraint_node *validatetrans;	/* special transition rules */
+	u32 value; /* class value */
+	char *comkey; /* common name */
+	struct common_datum *comdatum; /* common datum */
+	struct symtab permissions; /* class-specific permission symbol table */
+	struct constraint_node *constraints; /* constraints on class perms */
+	struct constraint_node *validatetrans; /* special transition rules */
 /* Options how a new object user, role, and type should be decided */
-#define DEFAULT_SOURCE         1
-#define DEFAULT_TARGET         2
+#define DEFAULT_SOURCE 1
+#define DEFAULT_TARGET 2
 	char default_user;
 	char default_role;
 	char default_type;
 /* Options how a new object range should be decided */
-#define DEFAULT_SOURCE_LOW     1
-#define DEFAULT_SOURCE_HIGH    2
-#define DEFAULT_SOURCE_LOW_HIGH        3
-#define DEFAULT_TARGET_LOW     4
-#define DEFAULT_TARGET_HIGH    5
-#define DEFAULT_TARGET_LOW_HIGH        6
+#define DEFAULT_SOURCE_LOW	1
+#define DEFAULT_SOURCE_HIGH	2
+#define DEFAULT_SOURCE_LOW_HIGH 3
+#define DEFAULT_TARGET_LOW	4
+#define DEFAULT_TARGET_HIGH	5
+#define DEFAULT_TARGET_LOW_HIGH 6
 #define DEFAULT_GLBLUB		7
 	char default_range;
 };
 
 /* Role attributes */
 struct role_datum {
-	u32 value;			/* internal role value */
-	u32 bounds;			/* boundary of role */
-	struct ebitmap dominates;	/* set of roles dominated by this role */
-	struct ebitmap types;		/* set of authorized types for role */
+	u32 value; /* internal role value */
+	u32 bounds; /* boundary of role */
+	struct ebitmap dominates; /* set of roles dominated by this role */
+	struct ebitmap types; /* set of authorized types for role */
 };
 
 struct role_trans_key {
-	u32 role;		/* current role */
-	u32 type;		/* program executable type, or new object type */
-	u32 tclass;		/* process class, or new object class */
+	u32 role; /* current role */
+	u32 type; /* program executable type, or new object type */
+	u32 tclass; /* process class, or new object class */
 };
 
 struct role_trans_datum {
-	u32 new_role;		/* new role */
+	u32 new_role; /* new role */
 };
 
 struct filename_trans_key {
-	u32 ttype;		/* parent dir context */
-	u16 tclass;		/* class of new object */
-	const char *name;	/* last path component */
+	u32 ttype; /* parent dir context */
+	u16 tclass; /* class of new object */
+	const char *name; /* last path component */
 };
 
 struct filename_trans_datum {
-	struct ebitmap stypes;	/* bitmap of source types for this otype */
-	u32 otype;		/* resulting type of new object */
-	struct filename_trans_datum *next;	/* record for next otype*/
+	struct ebitmap stypes; /* bitmap of source types for this otype */
+	u32 otype; /* resulting type of new object */
+	struct filename_trans_datum *next; /* record for next otype*/
 };
 
 struct role_allow {
-	u32 role;		/* current role */
-	u32 new_role;		/* new role */
+	u32 role; /* current role */
+	u32 new_role; /* new role */
 	struct role_allow *next;
 };
 
 /* Type attributes */
 struct type_datum {
-	u32 value;		/* internal type value */
-	u32 bounds;		/* boundary of type */
-	unsigned char primary;	/* primary name? */
-	unsigned char attribute;/* attribute ?*/
+	u32 value; /* internal type value */
+	u32 bounds; /* boundary of type */
+	unsigned char primary; /* primary name? */
+	unsigned char attribute; /* attribute ?*/
 };
 
 /* User attributes */
 struct user_datum {
-	u32 value;			/* internal user value */
-	u32 bounds;			/* bounds of user */
-	struct ebitmap roles;		/* set of authorized roles for user */
-	struct mls_range range;		/* MLS range (min - max) for user */
-	struct mls_level dfltlevel;	/* default login MLS level for user */
+	u32 value; /* internal user value */
+	u32 bounds; /* bounds of user */
+	struct ebitmap roles; /* set of authorized roles for user */
+	struct mls_range range; /* MLS range (min - max) for user */
+	struct mls_level dfltlevel; /* default login MLS level for user */
 };
 
-
 /* Sensitivity attributes */
 struct level_datum {
-	struct mls_level *level;	/* sensitivity and associated categories */
-	unsigned char isalias;	/* is this sensitivity an alias for another? */
+	struct mls_level *level; /* sensitivity and associated categories */
+	unsigned char isalias; /* is this sensitivity an alias for another? */
 };
 
 /* Category attributes */
 struct cat_datum {
-	u32 value;		/* internal category bit + 1 */
-	unsigned char isalias;  /* is this category an alias for another? */
+	u32 value; /* internal category bit + 1 */
+	unsigned char isalias; /* is this category an alias for another? */
 };
 
 struct range_trans {
@@ -147,7 +144,7 @@ struct range_trans {
 
 /* Boolean data type */
 struct cond_bool_datum {
-	__u32 value;		/* internal type value */
+	__u32 value; /* internal type value */
 	int state;
 };
 
@@ -173,20 +170,20 @@ struct type_set {
  */
 struct ocontext {
 	union {
-		char *name;	/* name of initial SID, fs, netif, fstype, path */
+		char *name; /* name of initial SID, fs, netif, fstype, path */
 		struct {
 			u8 protocol;
 			u16 low_port;
 			u16 high_port;
-		} port;		/* TCP or UDP port information */
+		} port; /* TCP or UDP port information */
 		struct {
 			u32 addr;
 			u32 mask;
-		} node;		/* node information */
+		} node; /* node information */
 		struct {
 			u32 addr[4];
 			u32 mask[4];
-		} node6;        /* IPv6 node information */
+		} node6; /* IPv6 node information */
 		struct {
 			u64 subnet_prefix;
 			u16 low_pkey;
@@ -198,11 +195,11 @@ struct ocontext {
 		} ibendport;
 	} u;
 	union {
-		u32 sclass;  /* security class for genfs */
-		u32 behavior;  /* labeling behavior for fs_use */
+		u32 sclass; /* security class for genfs */
+		u32 behavior; /* labeling behavior for fs_use */
 	} v;
-	struct context context[2];	/* security context(s) */
-	u32 sid[2];	/* SID(s) */
+	struct context context[2]; /* security context(s) */
+	u32 sid[2]; /* SID(s) */
 	struct ocontext *next;
 };
 
@@ -221,19 +218,19 @@ struct genfs {
 #define SYM_BOOLS   5
 #define SYM_LEVELS  6
 #define SYM_CATS    7
-#define SYM_NUM     8
+#define SYM_NUM	    8
 
 /* object context array indices */
-#define OCON_ISID	0 /* initial SIDs */
-#define OCON_FS		1 /* unlabeled file systems (deprecated) */
-#define OCON_PORT	2 /* TCP and UDP port numbers */
-#define OCON_NETIF	3 /* network interfaces */
-#define OCON_NODE	4 /* nodes */
-#define OCON_FSUSE	5 /* fs_use */
-#define OCON_NODE6	6 /* IPv6 nodes */
-#define OCON_IBPKEY	7 /* Infiniband PKeys */
-#define OCON_IBENDPORT	8 /* Infiniband end ports */
-#define OCON_NUM	9
+#define OCON_ISID      0 /* initial SIDs */
+#define OCON_FS	       1 /* unlabeled file systems (deprecated) */
+#define OCON_PORT      2 /* TCP and UDP port numbers */
+#define OCON_NETIF     3 /* network interfaces */
+#define OCON_NODE      4 /* nodes */
+#define OCON_FSUSE     5 /* fs_use */
+#define OCON_NODE6     6 /* IPv6 nodes */
+#define OCON_IBPKEY    7 /* Infiniband PKeys */
+#define OCON_IBENDPORT 8 /* Infiniband end ports */
+#define OCON_NUM       9
 
 /* The policy database */
 struct policydb {
@@ -243,15 +240,15 @@ struct policydb {
 	struct symtab symtab[SYM_NUM];
 #define p_commons symtab[SYM_COMMONS]
 #define p_classes symtab[SYM_CLASSES]
-#define p_roles symtab[SYM_ROLES]
-#define p_types symtab[SYM_TYPES]
-#define p_users symtab[SYM_USERS]
-#define p_bools symtab[SYM_BOOLS]
-#define p_levels symtab[SYM_LEVELS]
-#define p_cats symtab[SYM_CATS]
+#define p_roles	  symtab[SYM_ROLES]
+#define p_types	  symtab[SYM_TYPES]
+#define p_users	  symtab[SYM_USERS]
+#define p_bools	  symtab[SYM_BOOLS]
+#define p_levels  symtab[SYM_LEVELS]
+#define p_cats	  symtab[SYM_CATS]
 
 	/* symbol names indexed by (value - 1) */
-	char		**sym_val_to_name[SYM_NUM];
+	char **sym_val_to_name[SYM_NUM];
 
 	/* class, role, and user attributes indexed by (value - 1) */
 	struct class_datum **class_val_to_struct;
@@ -324,25 +321,25 @@ extern int policydb_role_isvalid(struct policydb *p, unsigned int role);
 extern int policydb_read(struct policydb *p, void *fp);
 extern int policydb_write(struct policydb *p, void *fp);
 
-extern struct filename_trans_datum *policydb_filenametr_search(
-	struct policydb *p, struct filename_trans_key *key);
+extern struct filename_trans_datum *
+policydb_filenametr_search(struct policydb *p, struct filename_trans_key *key);
 
-extern struct mls_range *policydb_rangetr_search(
-	struct policydb *p, struct range_trans *key);
+extern struct mls_range *policydb_rangetr_search(struct policydb *p,
+						 struct range_trans *key);
 
-extern struct role_trans_datum *policydb_roletr_search(
-	struct policydb *p, struct role_trans_key *key);
+extern struct role_trans_datum *
+policydb_roletr_search(struct policydb *p, struct role_trans_key *key);
 
-#define POLICYDB_CONFIG_MLS    1
+#define POLICYDB_CONFIG_MLS 1
 
 /* the config flags related to unknown classes/perms are bits 2 and 3 */
-#define REJECT_UNKNOWN	0x00000002
-#define ALLOW_UNKNOWN	0x00000004
+#define REJECT_UNKNOWN 0x00000002
+#define ALLOW_UNKNOWN  0x00000004
 
-#define OBJECT_R "object_r"
+#define OBJECT_R     "object_r"
 #define OBJECT_R_VAL 1
 
-#define POLICYDB_MAGIC SELINUX_MAGIC
+#define POLICYDB_MAGIC	SELINUX_MAGIC
 #define POLICYDB_STRING "SE Linux"
 
 struct policy_file {
@@ -366,7 +363,8 @@ static inline int next_entry(void *buf, struct policy_file *fp, size_t bytes)
 	return 0;
 }
 
-static inline int put_entry(const void *buf, size_t bytes, size_t num, struct policy_file *fp)
+static inline int put_entry(const void *buf, size_t bytes, size_t num,
+			    struct policy_file *fp)
 {
 	size_t len;
 
@@ -382,7 +380,8 @@ static inline int put_entry(const void *buf, size_t bytes, size_t num, struct po
 	return 0;
 }
 
-static inline char *sym_name(struct policydb *p, unsigned int sym_num, unsigned int element_nr)
+static inline char *sym_name(struct policydb *p, unsigned int sym_num,
+			     unsigned int element_nr)
 {
 	return p->sym_val_to_name[sym_num][element_nr];
 }
@@ -390,5 +389,4 @@ static inline char *sym_name(struct policydb *p, unsigned int sym_num, unsigned
 extern u16 string_to_security_class(struct policydb *p, const char *name);
 extern u32 string_to_av_perm(struct policydb *p, u16 tclass, const char *name);
 
-#endif	/* _SS_POLICYDB_H_ */
-
+#endif /* _SS_POLICYDB_H_ */
-- 
2.53.0

